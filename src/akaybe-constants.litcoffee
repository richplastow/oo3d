Akaybe Constants
================

#### Define the core Akaybe constants

Akaybe’s constants are visible to all code defined in ‘src/’ and ‘test/’, but 
hidden from code defined elsewhere in the app. 




Constants which help minification
---------------------------------

These strings can make `*.min.js` a little shorter and easier to read, and also 
make the source code less verbose: `ªO == typeof x` vs `'object' == typeof x`. 

    ªA = 'array'
    ªB = 'boolean'
    ªE = 'error'
    ªF = 'function'
    ªN = 'number'
    ªO = 'object'
    ªR = 'regexp'
    ªS = 'string'
    ªU = 'undefined'
    ªX = 'null'




Numeric Constants
-----------------

@todo describe

    ªMAX =  9007199254740991 # `Number.MAX_SAFE_INTEGER` in ES6
    ªMIN = -9007199254740991 # `Number.MIN_SAFE_INTEGER` in ES6




Constants for scope and environment
-----------------------------------

`ªW` is root scope, `window` in a browser. 

    ªW = @



