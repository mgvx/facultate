import React, { Component } from 'react';
import { Text,
AppRegistry,
View,
ListView,
Modal,
TextInput,
Picker,
Button,
AsyncStorage,
TouchableHighlight} from 'react-native';

const styles =  require('./style');
import Toolbar from "./Toolbar"
import MyButton from "./MyButton"

import * as firebase from 'firebase'
const firebaseConfig = {
  apiKey: "AIzaSyBhPuosX8VtNVEOPQI2-hxnUfAMbVFDqgA",
  authDomain: "jesushelpme-ec986.firebaseapp.com",
  databaseURL: "https://jesushelpme-ec986.firebaseio.com",
  projectId: "jesushelpme-ec986",
  storageBucket: "jesushelpme-ec986.appspot.com",
}
const firebaseApp = firebase.initializeApp(firebaseConfig);

export default class HomeScreen extends Component {
  static navigationOptions = {
    title: 'Transactions',
  };

  constructor(){
    super();
    const ds = new ListView.DataSource({rowHasChanged:(r1, r2)=> r1!== r2});


    this.categories = ["cat1", "cat2", "food", "rent"]
    this.accounts = ["BRD", "myAcc2", "piggybank"]

    this.itemsRef = this.getRef().child('items');
    this.renderRow = this.renderRow.bind(this);
    this.pressRow = this.pressRow.bind(this);

    this.items = []

    this.state = {
      category: this.categories[0],
      from:  this.accounts[0],
      to: this.accounts[0],
      sum: 0,

      addModalVisible: false,
      editModalVisible: false,
      selectedItem: null,
      itemDataSource: ds,
    }

    this.pickerCategories = this.categories.map( (s, i) => { return <Picker.Item key={i} value={s} label={s} /> });
    this.pickerAccounts = this.accounts.map( (s, i) => { return <Picker.Item key={i} value={s} label={s} /> });


  }

  unsetSelectedItem(){
    this.state.category = "";
    this.state.sum = 0;
    this.state.from = this.accounts[0];
    this.state.to = this.accounts[0];
  }

  setAddModalVisible(visible) {
    this.setState({addModalVisible:visible});
    if(!visible){this.unsetSelectedItem();}
  }
  setEditModalVisible(visible) {
    this.setState({editModalVisible:visible});
    if(!visible){this.unsetSelectedItem();}
  }

  getRef() {
    return firebaseApp.database().ref();
  }

  componentWillMount(){
    this.getItems(this.itemsRef);
  }

  componentDidMount(){
    this.getItems(this.itemsRef);
  }

  async _setItemsTask() {
    try {
      await AsyncStorage.setItem('listOfTransactions',  JSON.stringify(this.items));
      console.log("saved to memory");
      this._getItemsTask();
    } catch (error) {
      console.log("ERRROR set items");
    }
  }

  async _getItemsTask() {
    try {
      let response = await AsyncStorage.getItem('listOfTransactions');
      if (response !== null){
        this.items = await JSON.parse(response) || [];
        console.log("fetched from memory");
      }
    } catch (error) {
      console.log("ERRROR Get items");
    }
  }

  getItems(itemsRef){

    itemsRef.on('value',(snap)=> {
      let items = [];
      snap.forEach((child) => {
        items.push({
          category: child.val().category,
          sum:  child.val().sum,
          to:  child.val().to,
          from:  child.val().from,
          _key: child.key
        });
      });
      this.items = items;
      this.setState({
        itemDataSource: this.state.itemDataSource.cloneWithRows(items)
      });

    });
  }

  renderRow(item){
    return(
     <TouchableHighlight onPress={()=> {
          this.pressRow(item);
        }}>
        <View style = {styles.li}>
        <Text  style = {styles.liText}> {item.category} </Text>
        <Text  style = {styles.liText}> {item.sum} </Text>
        </View>
        </TouchableHighlight>
    );
  }

  pressRow(item){
    this.selectedItem = item
    this.state.category = item.category
    this.state.sum = item.sum
    this.state.from = item.from
    this.state.to = item.to
    this.setEditModalVisible(true);
    // this.itemsRef.child(item._key).remove();
  }

  getTransactionFields(x) {
    return (
      <View style = {styles.fieldsView}>
        <Text style= {styles.inputLabel}>Sum</Text>
        <TextInput
          style= {styles.inputText}
          value= {x.state.sum}
          placeholder="$$$"
          keyboardType = 'numeric'
          onChangeText = {(value)=> x.setState({sum:value})}
        />

        <Text style= {styles.inputLabel}>Category</Text>
        <Picker
          selectedValue={x.state.category}
          onValueChange={(itemValue, itemIndex) => x.setState({category: itemValue})}>
          {x.pickerCategories}
        </Picker>

        <Text style= {styles.inputLabel}>To</Text>
        <Picker
          selectedValue={x.state.to}
          onValueChange={(itemValue, itemIndex) => x.setState({to: itemValue})}>
          {x.pickerAccounts}
        </Picker>

        <Text style= {styles.inputLabel}>From</Text>
        <Picker
          selectedValue={x.state.from}
          onValueChange={(itemValue, itemIndex) => x.setState({from: itemValue})}>
          {x.pickerAccounts}
        </Picker>
      </View>
    )
  }

  render() {

    const { navigate } = this.props.navigation;
    return (
      <View style = {styles.container}>

            <Button
              title="Go to the latest Statistics..."
              onPress={() =>
                navigate('Stats')
              }
            />
        <Modal
          animationType="slide"
          transparent={false}
          visible={this.state.addModalVisible}
          onRequestClose={() => {}}
          >
         <View style= {styles.container}>

            <Toolbar title="Add Transaction"/>
            {this.getTransactionFields(this)}

            <MyButton onPress={() => {
              this.setAddModalVisible(!this.state.addModalVisible)
            }}
            title="Cancel"
            color="white"/>

            <MyButton onPress={() => {
              this.itemsRef.push({category:this.state.category, sum:this.state.sum, from:this.state.from, to:this.state.to});
              this.setAddModalVisible(!this.state.addModalVisible)
              this._setItemsTask()
            }}
            title="Submit"
            color="green"/>

         </View>
        </Modal>

        <Modal
          animationType="slide"
          transparent={false}
          visible={this.state.editModalVisible}
          onRequestClose={() => {}}
          >
         <View style= {styles.container}>
            <Toolbar title="Edit Transaction"/>
            {this.getTransactionFields(this)}

            <MyButton onPress={() => {
              this.setEditModalVisible(!this.state.editModalVisible)
            }}
            title="Cancel"
            color="white"/>

            <MyButton onPress={() => {
              this.itemsRef.child(this.selectedItem._key).remove();
              this.setEditModalVisible(!this.state.editModalVisible)
              this._setItemsTask()
            }}
            title="Delete"
            color="red"/>

            <MyButton onPress={() => {
              this.itemsRef.child(this.selectedItem._key).update({category:this.state.category, sum:this.state.sum, from:this.state.from, to:this.state.to});
              this.setEditModalVisible(!this.state.editModalVisible)
              this._setItemsTask()
            }}
            title="Submit"
            color="green"/>

         </View>
        </Modal>

        <ListView style = {styles.listView}
         dataSource = {this.state.itemDataSource}
         renderRow = {this.renderRow}
        />
         <MyButton onPress={() => {
           this.setAddModalVisible(true);
         }}
           title="Add Transaction"
           color="green"/>

      </View>
    );
  }
}

AppRegistry.registerComponent('HomeScreen', () => HomeScreen);
