'use strict';

exports.unsafeParseInt10 = function(str) {
    return parseInt(str, 10);
};

exports.unsafeParseIntBase = function(str) {
    return function(base) {
        return parseInt(str, base);
    };
};

exports.unsafeParseFloat = function(str) {
    return parseFloat(str);
};
