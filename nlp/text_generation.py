
from __future__ import absolute_import, division, print_function, unicode_literals
import tensorflow as tf
tf.enable_eager_execution()
import numpy as np
import os
import time


path_to_file = 'poezii.txt'

text = open(path_to_file, 'rb').read().decode(encoding='utf-8')

# print ('Length of text: {} characters'.format(len(text)))
# print(text[:250])


# The unique characters in the file
vocab = sorted(set(text))
print ('{} unique characters'.format(len(vocab)))


# Creating a mapping from unique characters to indices
char2idx = {u:i for i, u in enumerate(vocab)}
idx2char = np.array(vocab)

text_as_int = np.array([char2idx[c] for c in text])



# The maximum length sentence we want for a single input in characters
seq_length = 100
examples_per_epoch = len(text)//seq_length

# Create training examples / targets
char_dataset = tf.data.Dataset.from_tensor_slices(text_as_int)

# for i in char_dataset.take(5):
#   print(idx2char[i.numpy()])



sequences = char_dataset.batch(seq_length+1, drop_remainder=True)

def split_input_target(chunk):
    input_text = chunk[:-1]
    target_text = chunk[1:]
    return input_text, target_text

dataset = sequences.map(split_input_target)



# Batch size
BATCH_SIZE = 4 #64
steps_per_epoch = examples_per_epoch//BATCH_SIZE

# Buffer size to shuffle the dataset
# (TF data is designed to work with possibly infinite sequences,
# so it doesn't attempt to shuffle the entire sequence in memory. Instead,
# it maintains a buffer in which it shuffles elements).
BUFFER_SIZE = 10000

dataset = dataset.shuffle(BUFFER_SIZE).batch(BATCH_SIZE, drop_remainder=True)

dataset


# Length of the vocabulary in chars
vocab_size = len(vocab)

# The embedding dimension
embedding_dim = 256

# Number of RNN units
rnn_units = 1024

if tf.test.is_gpu_available():
  rnn = tf.keras.layers.CuDNNGRU
else:
  import functools
  rnn = functools.partial(tf.keras.layers.GRU, recurrent_activation='sigmoid')

def build_model(vocab_size, embedding_dim, rnn_units, batch_size):
  model = tf.keras.Sequential([
    tf.keras.layers.Embedding(vocab_size, embedding_dim,
                              batch_input_shape=[batch_size, None]),
    rnn(rnn_units,
        return_sequences=True,
        recurrent_initializer='glorot_uniform',
        stateful=True),
    tf.keras.layers.Dense(vocab_size)
  ])
  return model

model = build_model(
  vocab_size = len(vocab),
  embedding_dim=embedding_dim,
  rnn_units=rnn_units,
  batch_size=BATCH_SIZE)


def loss(labels, logits):
  return tf.keras.losses.sparse_categorical_crossentropy(labels, logits, from_logits=True)


model.compile(optimizer = tf.train.AdamOptimizer(), loss = loss)


# Directory where the checkpoints will be saved
checkpoint_dir = './training_checkpoints'
# Name of the checkpoint files
checkpoint_prefix = os.path.join(checkpoint_dir, "ckpt_{epoch}")

checkpoint_callback=tf.keras.callbacks.ModelCheckpoint(
    filepath=checkpoint_prefix,
    save_weights_only=True)



print("HEEEERE")

EPOCHS=3

# history = model.fit(dataset.repeat(), epochs=EPOCHS, steps_per_epoch=steps_per_epoch, callbacks=[checkpoint_callback])


# tf.train.latest_checkpoint(checkpoint_dir)

model = build_model(vocab_size, embedding_dim, rnn_units, batch_size=1)

model.load_weights(tf.train.latest_checkpoint(checkpoint_dir))

model.build(tf.TensorShape([1, None]))

model.summary()

def generate_text(model, start_string):
  # Evaluation step (generating text using the learned model)

  # Number of characters to generate
  # num_generate = 1000
  num_generate = 500

  # Converting our start string to numbers (vectorizing)
  input_eval = [char2idx[s] for s in start_string]
  input_eval = tf.expand_dims(input_eval, 0)

  # Empty string to store our results
  text_generated = []

  # Low temperatures results in more predictable text.
  # Higher temperatures results in more surprising text.
  # Experiment to find the best setting.
  temperature = 1.0

  # Here batch size == 1
  model.reset_states()
  for i in range(num_generate):
      predictions = model(input_eval)
      # remove the batch dimension
      predictions = tf.squeeze(predictions, 0)

      # using a multinomial distribution to predict the word returned by the model
      predictions = predictions / temperature
      predicted_id = tf.multinomial(predictions, num_samples=1)[-1,0].numpy()

      # We pass the predicted word as the next input to the model
      # along with the previous hidden state
      input_eval = tf.expand_dims([predicted_id], 0)

      text_generated.append(idx2char[predicted_id])

  return (start_string + ''.join(text_generated))

print(generate_text(model, start_string=u"Un glas "))


# model = build_model(
#   vocab_size = len(vocab),
#   embedding_dim=embedding_dim,
#   rnn_units=rnn_units,
#   batch_size=BATCH_SIZE)

optimizer = tf.train.AdamOptimizer()

# Training step
EPOCHS = 1

# for epoch in range(EPOCHS):
#     start = time.time()

#     # reinitializing the hidden state at the start of every epoch to None
#     hidden = model.reset_states()

#     for (batch_n, (inp, target)) in enumerate(dataset):
#           with tf.GradientTape() as tape:
#               # feeding the hidden state back into the model
#               # This is the interesting step
#               predictions = model(inp)
#               loss = tf.losses.sparse_softmax_cross_entropy(target, predictions)

#           grads = tape.gradient(loss, model.trainable_variables)
#           optimizer.apply_gradients(zip(grads, model.trainable_variables))

#           if batch_n % 100 == 0:
#               template = 'Epoch {} Batch {} Loss {:.4f}'
#               print(template.format(epoch+1, batch_n, loss))

#     # saving (checkpoint) the model every 5 epochs
#     if (epoch + 1) % 5 == 0:
#       model.save_weights(checkpoint_prefix.format(epoch=epoch))

#     print ('Epoch {} Loss {:.4f}'.format(epoch+1, loss))
#     print ('Time taken for 1 epoch {} sec\n'.format(time.time() - start))

# model.save_weights(checkpoint_prefix.format(epoch=epoch))


