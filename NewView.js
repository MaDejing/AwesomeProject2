/**
 * Created by MelanchoJy on 16/8/25.
 */

// import {requireNativeComponent } from 'react-native';
//
// // requireNativeComponent 自动把这个组件提供给 "MyNewViewManager"
// module.exports = requireNativeComponent('MyNewView', null);

// import React from 'react';
// import { requireNativeComponent, PropTypes, ScrollView } from 'react-native';

import React, { Component, PropTypes } from 'react';
import { requireNativeComponent, ScrollView } from 'react-native';

var MyNewView = requireNativeComponent('MyNewView', NewView);

export default class NewView extends ScrollView {
  static propTypes = {
    ...ScrollView.propTypes
  };

  constructor(props) {
    super(props);
  }

  render() {
    return <MyNewView {...this.props} />;
  }
}

// class NewView extends ScrollView {
//   static propTypes = {
//     ...ScrollView.propTypes,
//   };

//   constructor(props) {
//     super(props);

//     console.log(props);
//   }

//   render() {
//     return <MyNewView {...this.props} />;
//   }
// }

// module.exports = NewView;
