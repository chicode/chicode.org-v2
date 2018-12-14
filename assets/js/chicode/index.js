import '../../css/chicode.scss'
import 'phoenix_html'
import Vue from 'vue'

import route from 'riot-route'

route('/', () => import(/* webpackChunkName: "home" */ './home.js'))

route.start(true)
