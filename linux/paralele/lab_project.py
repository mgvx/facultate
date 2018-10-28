import threading
import numpy as np
from enum import Enum
import gym
from gym import envs
import cv2
import time
import copy
from mpi4py import MPI

img = cv2.imread('d.jpg',1)
img2 = copy.deepcopy(img)
kernel = np.array([[1.0,2.0,1.0], [2.0,4.0,2.0], [1.0,2.0,1.0]])
kernel = kernel / np.sum(kernel)

class tags(Enum):
    READY=1
    DONE=2
    EXIT=3
    START=4

# Initializations and preliminaries
comm = MPI.COMM_WORLD   # get MPI communicator object
size = comm.size        # total number of processes

rank = comm.rank        # rank of this process
status = MPI.Status()   # get MPI status object


def compute(x,y,z):
    global img2
    s = .0
    d = .0
    if x>0 and y>0:
        s += img[x-1][y-1][z] * kernel[0][0]
        d += kernel[0][0]
    if x>0:
        s += img[x-1][y][z] * kernel[0][1]
        d += kernel[0][1]
    if y>0:
        s += img[x][y-1][z] * kernel[1][0]
        d += kernel[1][0]
    if x<len(img)-1:
        s += img[x+1][y][z] * kernel[1][2]
        d += kernel[1][2]
    if y<len(img[x])-1:
        s += img[x][y+1][z] * kernel[2][1]
        d += kernel[2][1]
    if x<len(img)-1 and y<len(img[x])-1:
        s += img[1+x][y+1][z] * kernel[2][2]
        d += kernel[2][2]
    if x<len(img)-1  and y>0:
        s += img[x+1][y-1][z] * kernel[2][0]
        d += kernel[2][0]
    if x>0 and  y<len(img[x])-1:
        s += img[x-1][y+1][z] * kernel[0][2]
        d += kernel[0][2]
        
    img2[x][y][z] = s/d
    
def compute2(x,y,z):
    global img2
    s = .0
    d = .0
    if x>0 and y>0:
        s += img[x-1][y-1][z] * kernel[0][0]
        d += kernel[0][0]
    if x>0:
        s += img[x-1][y][z] * kernel[0][1]
        d += kernel[0][1]
    if y>0:
        s += img[x][y-1][z] * kernel[1][0]
        d += kernel[1][0]
    if x<len(img)-1:
        s += img[x+1][y][z] * kernel[1][2]
        d += kernel[1][2]
    if y<len(img[x])-1:
        s += img[x][y+1][z] * kernel[2][1]
        d += kernel[2][1]
    if x<len(img)-1 and y<len(img[x])-1:
        s += img[1+x][y+1][z] * kernel[2][2]
        d += kernel[2][2]
    if x<len(img)-1  and y>0:
        s += img[x+1][y-1][z] * kernel[2][0]
        d += kernel[2][0]
    if x>0 and  y<len(img[x])-1:
        s += img[x-1][y+1][z] * kernel[0][2]
        d += kernel[0][2]
        
    return [s/d,x,y,z]


def do_work(a):
    global img
    global img2
    for i in range(0,len(img[a])):
        for j in range(0,len(img[a][i])):
            compute(a,i,j)
    



def blur_t():
    global img
    threads = []
    for i in range(0,len(img)):
        t = threading.Thread(target=do_work, args=(i,))
        threads.append(t)
        t.start()
    for i in range(0,len(img)):
        threads[i].join()
    threads = []
    img = copy.deepcopy(img2)

def blur_mpi():
    global tags
    global rank
    global img
    global comm
    global size
    global status
    
    if rank == 0:
        # Master process executes code below
        tasks = len(img)
        task_index = 0
        num_workers = size - 1
        closed_workers = 0
        busy = 0
        print("Master starting with %d workers" , num_workers)
        while closed_workers < num_workers:
            data = comm.recv(source=MPI.ANY_SOURCE, tag=MPI.ANY_TAG, status=status)
            source = status.Get_source()
            tag = status.Get_tag()
            print("Master step tag",tag," ",source)
            if tag == tags.READY.value:
                # Worker is ready, so send it a task
                if task_index < tasks and busy<size -1:
                    comm.send(task_index, dest=source, tag=tags.START.value)
                    print("Sending task %d to worker %d" , (task_index, source))
                    task_index += 1
                    busy += 1
                else:
                    comm.send(None, dest=source, tag=tags.EXIT.value)
            elif tag == tags.DONE.value:
                results = data
                busy -= 1
                for r in results:
                    img2[r[1]][r[2]][r[3]]=r[0]
                print("Got data from worker " , source)
            elif tag == tags.EXIT.value:
                print("Worker %d exited." , source)
                closed_workers += 1
            else:
                pass
        img = copy.deepcopy(img2)
        print("Master finishing")
    else:
        # Worker processes execute code below
        name = MPI.Get_processor_name()
        print("I am a worker with rank %d on %s." , (rank, name))
        while True:
            comm.send(None, dest=0, tag=tags.READY.value)
            task = comm.recv(source=0, tag=MPI.ANY_TAG, status=status)

            tag = status.Get_tag()
            print("worker tag",tag," ",task)
            
            if tag == tags.START.value:
                # Do the work here
                print("begin work")
                results=[]
                for i in range(0,len(img[task])):
                    for j in range(0,len(img[task][i])):
                         results.append( compute2(task,i,j))
                print("begin sent")
                comm.send(results, dest=0, tag=tags.DONE.value)
                print("sent")
            elif tag == tags.EXIT.value:
                break

        comm.send(None, dest=0, tag=tags.EXIT.value)
    

def main():
    global img
    global img2

    if rank==0:
        img3 = copy.deepcopy(img)
    print(rank)
    start_time=time.time()
    blur_mpi()
    blur_mpi()
    
##    blur_t()
##    blur_t()
    print(time.time()-start_time)
    if rank==0:
        cv2.imshow('image',img3)
        cv2.imshow('blur',img2)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

main()
