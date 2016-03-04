var riot = require("riot")
var postcss = require("postcss")
var autoprefixer = require("autoprefixer")
var less = require("less")
var lessCompile = function(input){
    var css = ""
    less.render(input, {sync:true}, (err, output)=>{
        css = output.css
    });
    return css;
}
riot.parsers.css.autoprefixer = function(tagName, css){
    css = lessCompile(css)
    var processer = postcss([autoprefixer])
    var output =  processer.process(css).css
    return output
};
// var riot = require('riot'),
var loaderUtils = require('loader-utils');

module.exports = function (source) {

  var content = source;
  var options = loaderUtils.parseQuery(this.query);

  if (this.cacheable) this.cacheable();

  Object.keys(options).forEach(function(key) {
    switch(options[key]) {
      case 'true':
        options[key] = true;
        break;
      case 'false':
        options[key] = false;
        break;
      case 'undefined':
        options[key] = undefined;
        break;
      case 'null':
        options[key] = null;
        break;
    }
  });

  try {
    return riot.compile(content, options);
  } catch (e) {
    throw new Error(e);
  }
};
