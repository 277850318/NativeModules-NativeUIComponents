import React, { Component } from 'react';
var { requireNativeComponent } = require('react-native');

// 将OC代码中的RCTTestManager返回的原生UI组件与react-native中自定义的TestView组件关联起来
var RCTTest = requireNativeComponent('RCTTest', TestView);

export default class TestView extends Component {
    render() {
        return <RCTTest/>;
    }
}