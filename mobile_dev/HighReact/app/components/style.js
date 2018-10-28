'use strict'
let React = require('react-native');
let {StyleSheet} = React;
const constants ={
  actionColor:'#3cb371'
}
module.exports = StyleSheet.create({
  container: {
    backgroundColor: '#f2f2f2',
    flex: 1,
  },
  listView: {
    backgroundColor: '#fff',
    flex: 1,
  },
  li: {
    backgroundColor: '#fff',
    borderBottomColor: '#eee',
    borderColor: 'transparent',
    borderWidth: 1,
    paddingLeft: 16,
    paddingBottom: 16,
    paddingTop: 14,
    padding: 2,
  },
  liContainer:{
    backgroundColor: '#fff',
    flex:2,
  },
  liText: {
    color: '#333',
    fontSize: 16,
  },
  navbar: {
    alignItems: 'center',
    backgroundColor: '#E0E0E0',
    borderBottomColor: '#eee',
    borderColor: 'transparent',
    borderWidth: 2,
    justifyContent: 'center',
    height: 66,
    flexDirection: 'row',
  },
  navbarTitle: {
    color: '#444',
    fontSize: 20,
    fontWeight: "500",
  },
  toolbar: {
    backgroundColor: '#fff',
    height: 22,
  },
  actionWhite:{
    backgroundColor: "#BEBEBE",
    borderWidth: 1,
    borderColor: 'transparent',
    paddingLeft: 16,
    paddingBottom: 16,
    paddingTop: 14,
  },
  actionGreen:{
    backgroundColor: "#3cb371",
    borderWidth: 1,
    borderColor: 'transparent',
    paddingLeft: 16,
    paddingBottom: 16,
    paddingTop: 14,
  },
  actionRed:{
    backgroundColor: "#FF6A6A",
    borderWidth: 1,
    borderColor: 'transparent',
    paddingLeft: 16,
    paddingBottom: 16,
    paddingTop: 14,
  },
  actionText: {
    color: '#fff',
    fontSize: 18,
    textAlign: 'center',
  },
  inputText: {
    fontSize: 16,
    backgroundColor: '#fff',
    borderBottomColor: '#eee',
    borderColor: 'transparent',
    borderWidth: 1,
    paddingLeft: 16,
    paddingBottom: 16,
    paddingTop: 14,
    padding: 2,
  },
  inputLabel: {
    fontSize: 16,
    fontWeight: "400",
    fontStyle: "italic",
    color: "grey",
    padding: 2,
  },
  fieldsView: {
    paddingLeft: 16,
    paddingTop: 14,
    backgroundColor: '#fff',
    flex: 1,
  },
});
