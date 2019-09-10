const path = require('path');
const glob = require('glob');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const Dotenv = require('dotenv-webpack');

let config_a = {
 entry: {
     './js/live_event_socket.js': ['./js/live_event_socket_index.js'].concat(glob.sync('./vendor/**/*.js'))
 },
 output: {
   filename: 'live_event_socket.js',
   path: path.resolve(__dirname, '../priv/static/js'),
   libraryTarget: 'var',
   library: 'LiveEventSocket',
 },
 module: {
   rules: [
     {
       test: /\.js$/,
       exclude: /node_modules/,
       use: {
         loader: 'babel-loader'
       }
     }
   ]
 },
  plugins: [
    new Dotenv({
      path: path.resolve(__dirname,'.env')
    })
  ]
}

let config_b = {
 entry: {
     './js/pusher_index.js': ['./js/pusher_index.js'].concat(glob.sync('./vendor/**/*.js'))
 },
 output: {
   filename: 'pusher.js',
   path: path.resolve(__dirname, '../priv/static/js'),
   libraryTarget: 'var',
   library: 'LiveEventPusher',
 },
 module: {
   rules: [
     {
       test: /\.js$/,
       exclude: /node_modules/,
       use: {
         loader: 'babel-loader'
       }
     }
   ]
 },
  plugins: [
    new Dotenv({
      path: path.resolve(__dirname,'.env')
    })
  ]
}

module.exports = [
    config_a,
    config_b
];
