import React, { Component } from 'react';
import { Text,
AppRegistry,
View,
ListView,
Modal,
TextInput,
Picker,
Platform,
StatusBar,
AsyncStorage,
TouchableHighlight} from 'react-native';

import {
  StackNavigator,
} from 'react-navigation';

import HomeScreen from "./app/components/HomeScreen"
import StatisticsScreen from "./app/components/StatisticsScreen"


const SimpleApp = StackNavigator({
  Home: { screen: HomeScreen },
  Stats: { screen: StatisticsScreen },
},
{
  cardStyle: {
    paddingTop: Platform.OS === 'ios' ? 0 : StatusBar.currentHeight
  }
});

export default class App extends React.Component {
  render() {
    return <SimpleApp />;
  }
}
//  <AddButton onPress={this.addItem.bind(this)} title="Add Transaction" />
