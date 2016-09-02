/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  TextInput,
  TouchableOpacity,
  AlertIOS,
  ScrollView,
  Modal,
  TouchableHighlight,
  Dimensions,
  NativeModules
} from 'react-native';

var NewView = require('./NewView');
const MyNewViewManager = NativeModules.MyNewViewManager;
const { width, height } = Dimensions.get('window');

class AwesomeProject2 extends Component {

  constructor(props) {
    super(props);

    this.state = {
      mobile: '',
      vcode: ''
    };
  }

  componentDidMount() {
    const json = {
      "employees": [
        {"firstName": "John", "lastName": "Doe"},
        {"firstName": "Anna",	"lastName": "Smith"},
        {"firstName": "Peter", "lastName": "Jones"}
      ]
    };
    // console.log(json);
    // MyNewViewManager.printLog(json, () => {});
  }

  componentWillMount(){
    this._gestureHandlers = {
      onStartShouldSetResponder: () => true,
      onMoveShouldSetResponder: ()=> false,
      onResponderGrant: ()=>{},
      onResponderMove: ()=>{},
      onResponderRelease: ()=>{}
    }
  }

  render() {
    return (
      <Modal>
        <View
          {...this._gestureHandlers}
          style={styles.modal}
        >
        </View>

        <NewView style={styles.container}>
          <View style={styles.wrap}>
            <View style={styles.itemWrap}>
              <View style={styles.textCon}>
                <TextInput ref="mobile"
                           onChangeText={(text) => this.setState({mobile: text})}
                           keyboardType="phone-pad"
                           maxLength={11}
                           value={this.state.mobile}
                           placeholder="手机号码"
                           style={styles.text}/>
              </View>
              <View style={[styles.zoneCode, styles.center]}>
                <Text style={{color: 'rgba(31, 31, 31, 0.5)', fontSize: 18, backgroundColor: '#fff'}}>+86</Text>
              </View>
            </View>

            <View style={styles.itemWrap}>
              <View style={styles.textCon}>
                <TextInput ref="code"
                           onChangeText = {(text) => this.setState({vcode: text})}
                           value={this.state.vcode}
                           maxLength={6}
                           keyboardType="numeric"
                           placeholder="验证码"
                           returnKeyType={ 'done' }
                           style={[styles.text, {paddingLeft: 20}]} />
              </View>
            </View>

            <Text style={{color: '#fff', fontSize: 11, textAlign: 'center', marginBottom: 10}}>您的手机号只用来接收验证码，我们不会保留任何相关数据</Text>

            <TouchableOpacity
              onPress={() => {
                      if (this.state.mobile && this.state.vcode) {
                        AlertIOS.alert(
                            'Login Title',
                            'Login!',
                            [
                                {text: 'OK', onPress: () => {}}
                            ]
                         );
                      }
                  }}
              style={[styles.loginBtn,
                      styles.center,
                      !this.state.mobile || !this.state.vcode.length ? styles.expireBtn : null]}>
              <Text style={styles.loginBtnText}>登录</Text>
            </TouchableOpacity>
          </View>
        </NewView>
      </Modal>
    );
  }
}

const styles = StyleSheet.create({
  modal: {
    flex: 1,
    // justifyContent: 'center',
    backgroundColor: 'rgba(0, 0, 0, 0.9)'
  },
  container: {
    position: 'absolute',
    top: height/6,
    left: 10,
    height: height*2/3,
    width: width-20,
    borderRadius:8,
    backgroundColor: 'rgb(0, 97, 243)'
  },
  center: {
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center'
  },
  wrap: {
    // flex: 1,
    paddingTop: 500,
    flexDirection: 'column',
    alignItems: 'center'
  },
  itemWrap: {
    // flex: 1,
    flexDirection: 'column',
    alignItems: 'center',
    marginBottom: 14,
    height: 58
  },
  textCon:{
    width: 280,
    height: 58,
    borderRadius: 10,
    overflow:'hidden',
    backgroundColor: '#fff',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
  },
  text: {
    paddingLeft: 80,
    //borderRadius: 10,
    margin:3,
    width: 274,
    height: 52,
    padding: 10,
    backgroundColor: 'transparent'
  },
  zoneCode: {
    position: 'absolute',
    left: 0,
    top: 0,
    width: 60,
    height: 55,
    borderRightWidth: 1,
    borderColor: 'rgb(235, 235, 235)',
    borderStyle: 'solid'
  },
  loginBtn: {
    width: 280,
    height: 55,
    backgroundColor: 'rgb(0, 202, 255)',
    borderRadius: 5
  },
  loginBtnText: {
    fontSize: 22,
    color: '#fff'
  },
  expireBtn:{
    backgroundColor:'#d9d9d9'
  }
});

AppRegistry.registerComponent('AwesomeProject2', () => AwesomeProject2);
