<template>
<div>
  <codemirror
    ref="cm"
    :options="cmOptions"
    :value="code"
    @input="setCode"
    @ready="init"
  />
</div>
</template>

<script>
import { codemirror } from 'vue-codemirror'

import 'codemirror/mode/javascript/javascript.js'
import 'codemirror/lib/codemirror.css'
import 'codemirror/addon/edit/matchbrackets.js'

export default {
  name: 'CodeMirror',

  components: { codemirror },

  props: ['code', 'setCode'],

  computed: {
    cm() {
      return this.$refs.cm ? this.$refs.cm.codemirror : null
    },
    cmOptions() {
      return {
        tabSize: 2,
        mode: 'text/javascript',
        lineNumbers: true,
        matchBrackets: true,
        autoRefresh: true,
        extraKeys: {
          Tab: (cm) => cm.execCommand('indentMore'),
          'Shift-Tab': (cm) => cm.execCommand('indentLess'),
        },
      }
    },
  },

  methods: {
    init() {
      // must wait for webfonts to finish loading, or else editor will be improperly initialized
      document.fonts.ready.then(() => {
        if (this.cm) this.cm.refresh()
      })
    },
  },
}
</script>
