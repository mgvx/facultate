import React, { Component } from 'react';
import { Text,
AppRegistry,
View,
ListView,
Modal,
TextInput,
Picker,
AsyncStorage,
StyleSheet,
Animated,
TouchableHighlight} from 'react-native';

import { Bar } from 'react-native-pathjs-charts'


const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f7f7f7',
  },
});


export default class StatisticsScreen extends Component {
  static navigationOptions = {
    title: 'Statistics',
  };

  constructor() {
    super();
    this.categories = ["cat1", "cat2", "food", "rent"]
    this.accounts = ["BRD", "myAcc2", "piggybank"]
    this.items = [];
    this.data = [];
    this.state = {
      loaded: 'false',
    };
  }

    componentWillMount(){
      this.setState({loaded: 'false'});
      this._getItemsTask();
    }


  async _getItemsTask() {
    try {
      let response = await AsyncStorage.getItem('listOfTransactions');
      if (response !== null){
        this.items = await JSON.parse(response) || [];
        this.data = []
        console.log(this.items)
        for (var k in this.categories){
          var s = 1;
          for (var i in this.items){
            if ( this.categories[k] == this.items[i]["category"]){
              s += parseInt(this.items[i]["sum"])

              console.log(s)
            }
          }
          var obj = {
            "v": s,
            "name": this.categories[k]
          }
          this.data.push([obj]);
        }
        console.log("populated data");
        this.setState({loaded: 'true'});
      }
    } catch (error) {
      console.log("ERRROR Get ittems");
    }
  }

  render() {
    let options = {
      width: 300,
      height: 300,
      margin: {
        top: 20,
        left: 25,
        bottom: 50,
        right: 20
      },
      color: '#2980B9',
      gutter: 20,
      animate: {
        type: 'oneByOne',
        duration: 200,
        fillTransition: 3
      },
      axisX: {
        showAxis: true,
        showLines: true,
        showLabels: true,
        showTicks: true,
        zeroAxis: false,
        orient: 'bottom',
        label: {
          fontFamily: 'Arial',
          fontSize: 18,
          fontWeight: true,
          fill: '#34495E',
          rotate: 45
        }
      },
      axisY: {
        showAxis: true,
        showLines: true,
        showLabels: true,
        showTicks: true,
        zeroAxis: false,
        orient: 'left',
        label: {
          fontFamily: 'Arial',
          fontSize: 12,
          fontWeight: true,
          fill: '#34495E'
        }
      }
    }

    if (this.state.loaded === 'false') {
          return (
            <View><Text>Loading...</Text></View>
          );
    }
    return (
      <View style={styles.container}>
        <Bar data={this.data} options={options} accessorKey='v'/>
      </View>
    );
     }
}

AppRegistry.registerComponent('StatisticsScreen', () => StatisticsScreen);
