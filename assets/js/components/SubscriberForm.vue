<template>
<div class="subscriber-form">
  <div class="form" @submit="submit">
    <input name="email" placeholder="joe@joe.party" type="text" class="input" v-model="email">
    <button class="submit" @click="submit">done</button>
  </div>
  <p v-if="status === 'ok'" class="small text-green">subscribed.</p>
  <p v-else-if="status === 'error'" class="small text-red">{{ this.error }}</p>
  <p v-else class="small text-weight-bold">no spam. ever.</p>
</div>
</template>

<script>
import _ from 'lodash'

export default {
  name: 'SubscriberForm',
  data: () => ({
    error: '',
    status: '',
    email: '',
  }),
  props: {
    location: {
      required: true,
    },
    type: {
      require: true,
    }
  },
  methods: {
    async submit() {
      const resp = await fetch('/', {
        method: 'post',
        body: { email: this.email, location: this.location, type: this.type } |> JSON.stringify,
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
}
</script>

<style lang="scss">
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
