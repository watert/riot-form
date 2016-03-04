let riot = window.riot = require("riot");
riot.util.tmpl.errorHandler = function (err) {
  console.error(err.message + ' in ' + err.riotData.tagName) // your error logic here
};
["demo"].forEach((tag)=> {require(`./tags/${tag}.tag`)})
require("./tags/demo.tag")
riot.mount("*")
