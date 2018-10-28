import React, { Component } from 'react';
import { Text,
        AppRegistry,
        View,
        TouchableHighlight } from 'react-native';

const styles =  require('./style');
const constants = styles.constants;

export default class MyButton extends Component {
  render() {
    let s = styles.actionWhite;
    let u = "#A9A9A9";
    if(this.props.color == "green"){
      s = styles.actionGreen;
      u = "#24ce84";
    }
    else if (this.props.color == "red") {
      s = styles.actionRed;
      u = "#FF3030";
    }

    return (
        <TouchableHighlight
          style = {s}
          underlayColor={u}
          onPress={this.props.onPress}
          >
          <Text style = {styles.actionText}>
            {this.props.title}
          </Text>
        </TouchableHighlight>
    );
  }
}

AppRegistry.registerComponent('MyButton', () => MyButton);
