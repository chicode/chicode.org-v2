<template>
<p v-if="status === 'ok'" class="small text-green">subscribed.</p>
<p v-else-if="status === 'error'" class="small text-red">{{ this.error }}</p>
<p v-else class="small text-weight-bold">no spam. ever.</p>
</template>

<script>
import _ from 'lodash'

const formToJson = (form) =>
  new FormData(form).entries() |> _.toArray |> _.fromPairs |> JSON.stringify

export default {
  name: 'SubscriberForm',
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
        mode: 'cors',
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
}
</script>
