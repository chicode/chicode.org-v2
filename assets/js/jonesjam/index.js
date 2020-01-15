import '../../css/jonesjam.scss'
import 'phoenix_html'

import route from 'riot-route'

route('/', () => import(/* webpackChunkName: "home" */ './home.js'));
route('/thank-you', () => import(/* webpackChunkName: "thank-you" */ './thank-you.js'));

route.start(true);
