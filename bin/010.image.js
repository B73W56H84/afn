#!/bin/env node

"use strict";
"use strong";

const DIRECTORY = './images/temp/';
let fs = require('fs');

// file name format: 0050_ラベンダー.png
fs.readdir( DIRECTORY, (error, files) => {
  if (error) throw error;

  let result = new Object();
  files.forEach((f) => {
    let check = f.match(/^(\d\d\d\d)_.*png$/);
    if( ! check ){
      // continue
      return;
    }

    // 0050 -> 50
    let number = parseInt(check[1], 10);

    let file_path = DIRECTORY + f;
    let base64ed = fs.readFileSync( file_path, 'base64', (err, data) => {
      if (err) throw err;

      return data;
    });

    result[ number ] = 'data:image/png;base64,' + base64ed;
  });

  console.log( JSON.stringify( result ) );
});
