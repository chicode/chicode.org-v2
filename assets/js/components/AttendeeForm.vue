<template>
<div>
  <div class="row">
    <div class="col-sm">
      <input placeholder="first name" name="first_name" v-model="data.first_name">
      <p v-if="this.errors.first_name">{{ this.errors.first_name[0] }}</p>
    </div>
    <div class="col-sm">
      <input placeholder="last name" name="last_name" v-model="data.last_name">
      <p v-if="this.errors.last_name">{{ this.errors.last_name[0] }}</p>
    </div>
  </div>
  <div class="row">
    <div class="col-sm">
      <input placeholder="gender" name="gender" v-model="data.gender">
      <p v-if="this.errors.gender">{{ this.errors.gender[0] }}</p>
    </div>
    <div class="col-sm">
      <input placeholder="ethnicity" name="ethnicity" v-model="data.ethnicity">
      <p v-if="this.errors.ethnicity">{{ this.errors.ethnicity[0] }}</p>
    </div>
  </div>
  <div class="row">
    <div class="col-sm">
      <input placeholder="school" name="school" v-model="data.school">
      <p v-if="this.errors.school">{{ this.errors.school[0] }}</p>
    </div>
    <div class="col-sm">
      <input placeholder="grade" name="grade" v-model="data.grade"
        type="number" min="6" max="12">
      <p v-if="this.errors.grade">{{ this.errors.grade[0] }}</p>
    </div>
  </div>
  <button class="mt-4" @click="submit">
    <img :src="this.image">
    finish by signing in
  </button>
</div>
</template>

<script>
import _ from 'lodash'
/*
const Input = {
  props: [name, model],
  render () {
    return (<div>
      <input placeholder={this.name} name={this.name} v-model=>
      <p v-if="this.errors.school">{{ this.errors.school }}</p>
    </div>)
  }
}
*/

const toObject = _.curry((keyFunc, valFunc, input) =>
  _.zipObject(_.map(keyFunc, input), _.map(valFunc, input))
)

const properties = ['firstname', 'lastname', 'gender', 'ethnicity', 'school', 'grade']

export default {
  name: 'AttendeeForm',
  data: () => ({
    errors: {},
    data: toObject(_.identity, _.stubString, properties),
  }),
  props: {
    successLocation: String,
    image: String,
  },
  methods: {
    async submit() {
      let currBody = JSON.parse(localStorage.getItem('currBody'))
      this.data.head = currBody[0]
      this.data.torso = currBody[1]
      this.data.legs = currBody[2]

      console.log(this.data)
      const resp = await fetch('/', {
        method: 'post',
        body: JSON.stringify(this.data),
        headers: {
          'Content-Type': 'application/json',
        },
      })

      if (resp.status === 200) {
        window.location.href = this.successLocation
      } else {
        const { errors } = await resp.json()

        this.errors = errors
      }
    },
  },
  watch: {
    
  }
}
</script>
