import React, { Component } from 'react';
import { Text,
AppRegistry,
StatusBar,
View } from 'react-native';

const styles =  require('./style');

export default class Toolbar extends Component {
  render() {
    return (
      <View>
        <StatusBar
          backgroundColor="blue"
          barStyle="light-content"
        />
        <View style = {styles.navbar}>
          <Text style = {styles.navbarTitle}>
            {this.props.title}
          </Text>
        </View>
      </View>
    );
  }
}

AppRegistry.registerComponent('Toolbar', () => Toolbar);
