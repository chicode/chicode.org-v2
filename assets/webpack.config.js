const path = require('path')
const glob = require('glob')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const UglifyJsPlugin = require('uglifyjs-webpack-plugin')
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const VueLoaderPlugin = require('vue-loader/lib/plugin')
const ImageminPlugin = require('imagemin-webpack-plugin').default

module.exports = (_env, _options) => ({
  mode: process.env.NODE_ENV,
  optimization: {
    minimizer: [
      new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({}),
    ],
  },
  entry: {
    chicode: ['@babel/polyfill', './js/chicode/index'],
    jonesjam: './js/jonesjam',
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static'),
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader',
      },
      {
        test: /\.(sa|sc|c)ss$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader'],
      },
      {
        test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
        use: {
          loader: 'file-loader',
          options: {
            // hacky fix to account for the fact that the output is relative to the js directory (because that's the output path)
            outputPath: './',
            publicPath: '/',
            name: '[path][name].[ext]',
          },
        },
      },
    ],
  },
  resolve: {
    alias: {
      vue$: 'vue/dist/vue.esm.js',
    },
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: './css/[name].css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: './' }]),
    new ImageminPlugin({
      test: /\.(jpe?g|png|gif|svg)$/,
      disable: process.env.NODE_ENV !== 'production',
      optipng: {
        optimizationLevel: 9,
      },
    }),
    new VueLoaderPlugin(),
  ],
})
