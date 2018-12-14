import _ from 'lodash'
import Vue from 'vue'

const formToJson = (form) =>
  new FormData(form).entries() |> _.toArray |> _.fromPairs |> JSON.stringify

Vue.component('subscriber-form', {
  template: '#subscriber-form-template',
  data: () => ({
    error: '',
    status: '',
  }),
  methods: {
    async submit(e) {
      e.preventDefault()

      const resp = await fetch(e.target.action, {
        method: 'post',
        body: formToJson(e.target),
        headers: {
          'Content-Type': 'application/json',
        },
      })

      if (resp.status === 200) {
        this.status = 'ok'
      } else {
        const { errors } = await resp.json()

        this.error = errors.email[0]
        this.status = 'error'
      }
    },
  },
})
