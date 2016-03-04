var path = require("path")
module.exports = {
    entry: {
        // hotdev:'webpack-hot-middleware/client?reload=true',
        // hotdev:'webpack-hot-middleware/client?path=/dev/assets/&timeout=1000&overlay=false',
        // main: [path.resolve("./public/src/main.js")],
        "riot-form": path.resolve("./src/index.js"),
        "demos": path.resolve("./demos/main.js"),
    },
    devtool:'source-map',
    output: {
        library:"[name]",
        libraryTarget:"umd",
        path: path.resolve("./dist/"),
        filename: "[name].js"
    },
    plugins:[],
    module:{
	    preLoaders: [
	      { test: /\.tag$/, exclude: /node_modules/, loader: path.resolve('libs/riotjs-loader') }
	    ],
        loaders: [
        //   { test: /\.js$|\.tag$/, exclude: /node_modules/, loader: 'babel-loader' }
          { test: /\.js$|\.tag$/, exclude: /node_modules/, loader: 'babel-loader?presets[]=es2015&compact=false' }
        ]
    },
    resolve: {
        alias:{
            "jquery": path.resolve(__dirname, "node_modules", "jquery", "dist", "jquery.min.js"), // __dirname+"/node_modules/jquery/dist/jquery.min.js",
            // "riot":path.resolve(__dirname, "node_modules","riot","riot.min.js"),
        },
        root: [
            path.resolve(__dirname,"public/src"),
            path.resolve(__dirname,"node_modules"),
        ]
    }
}
