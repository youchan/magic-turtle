const path = require('path');
const OwlResolver = require('opal-webpack-loader/resolver');
const CompressionPlugin = require("compression-webpack-plugin"); // for gzipping the packs
const TerserPlugin = require('terser-webpack-plugin');
const WebpackAssetsManifest = require('webpack-assets-manifest');

const common_config = {
    context: path.resolve(__dirname, '../opal'),
    mode: "production",
    optimization: {
        minimize: true, // minimize
        minimizer: [new TerserPlugin({ parallel: true, cache: true })]
    },
    performance: {
        maxAssetSize: 20000000,
        maxEntrypointSize: 20000000
    },
    output: {
        filename: '[name]-[chunkhash].js', // include fingerprint in file name, so browsers get the latest
        path: path.resolve(__dirname, '../public/assets'),
        publicPath: '/assets/'
    },
    resolve: {
        plugins: [
            new OwlResolver('resolve', 'resolved') // resolve ruby files
        ]
    },
    plugins: [
        new CompressionPlugin({ test: /^((?!application_ssr).)*$/, cache: true }), // gzip compress, exclude application_ssr.js
        new WebpackAssetsManifest({ publicPath: true, merge: true }) // generate manifest
    ],
    module: {
        rules: [
            {
                test: /\.scss$/,
                use: [
                    { loader: "cache-loader" },
                    { loader: "style-loader" },
                    {
                        loader: "css-loader",
                        options: {
                            sourceMap: false, // set to false to speed up hot reloads
                        }
                    },
                    {
                        loader: "sass-loader",
                        options: {
                            includePath: [path.resolve(__dirname, '../styles')],
                            sourceMap: false // set to false to speed up hot reloads
                        }
                    }
                ]
            },
            {
                // loader for .css files
                test: /\.css$/,
                use: [ "cache-loader", "style-loader", "css-loader" ]
            },
            {
                test: /\.(png|svg|jpg|gif|woff|woff2|eot|ttf|otf)$/,
                use: [
                  {
                    loader: "file-loader",
                    options: {
                      name: '[name].[ext]',
                      outputPath: 'fonts/'
                    }
                  }
                ]
            },
            {
                // opal-webpack-loader will compile and include ruby files in the pack
                test: /(\.js)?\.rb$/,
                use: [
                    { loader: "cache-loader" },
                    {
                        loader: 'opal-webpack-loader',
                        options: {
                            sourceMap: false,
                            hmr: false
                        }
                    }
                ]
            }
        ]
    }
};

const browser_config = {
    target: 'web',
    entry: {
      application: [path.resolve(__dirname, '../javascripts/application.js')],
      login: [path.resolve(__dirname, '../javascripts/login.js')],
      signup: [path.resolve(__dirname, '../javascripts/signup.js')],
      list: [path.resolve(__dirname, '../javascripts/list.js')],
      public_list: [path.resolve(__dirname, '../javascripts/public_list.js')],
      set_password: [path.resolve(__dirname, '../javascripts/set_password.js')]
    }
};

const browser = Object.assign({}, common_config, browser_config);

module.exports = [ browser ];
