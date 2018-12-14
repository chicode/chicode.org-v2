import '../../css/chicode.scss'
import 'phoenix_html'
import Vue from 'vue'

import route from 'riot-route'

route('/', () =>
  import(/* webpackChunkName: "home" */ './home.js').then(() => new Vue({ el: '#root' })),
)

route.start(true)
