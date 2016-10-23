import React, { Component } from 'react';
import { AppRegistry, View, NativeModules } from 'react-native';
import TestView  from './RCTTest';

var Test = NativeModules.Test;
Test.printAction();

class TestX extends Component {


    render() {
        return (
            <View style={{padding: 10}}>
                <TestView style={{width: 500, height: 50, backgroundColor: 'green'}} />
            </View>
        );
    }
}

AppRegistry.registerComponent('RNInit', () => TestX);