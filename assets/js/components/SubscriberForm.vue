<template>
<div class="subscriber-form">
  <form class="form" action="/" @submit="submit">
    <input id="email" name="email" placeholder="joe@joe.party" type="text" class="input">
    <input id="location" name="location" type="hidden" value="events__interest">
    <button type="submit" class="submit">done</button>
  </form>
  <p v-if="status === 'ok'" class="small text-green">subscribed.</p>
  <p v-else-if="status === 'error'" class="small text-red">{{ this.error }}</p>
  <p v-else class="small text-weight-bold">no spam. ever.</p>
</div>
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

<style lang="scss">
@import "../../css/app.scss";

.subscriber-form {
  font-family: Chicago;

  .form {
    max-width: 400px;
    display: flex;

    // fix for element sticking out on firefox
    justify-content: space-around;
    box-sizing: content-box;

    .input {
      flex: 1;
      color: black;
    }
  }
}
</style>
