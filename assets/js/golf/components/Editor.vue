<template>
  <div class="row">
    <codemirror code="code" setCode="setCode" />
    <div>
      <canvas width="300" height="300"></canvas>
      <div class="d-flex">
        <button @click="run">run</button>
        <div class="indicator">
          <p>{{ tokenCount() }}</p>
          <p>tokens</p>
        </div>
        <div class="indicator">
          <p>{{ lineCount() }}</p>
          <p>lines</p>
        </div>
      </div>
      <input placeholder="name">
      <div>
        <button @click="submit">submit</button>
        <p>(you can still work on it after)</p>
      </div>
    </div>
  </div>
</template>

<script>
import CodeMirror from './CodeMirror.vue'

export default {
  name: 'Editor',
  data: () => ({
    code: '',
  }),
  components: { CodeMirror },
  computed: {
    tokenCount() {
      return this.code.split(' ')
    },
    lineCount() {
      return this.code.split('\n')
    },
  },
  methods: {
    setCode(code) {
      this.code = code
    },
    run() {},
    submit() {},
  },
}
</script>
