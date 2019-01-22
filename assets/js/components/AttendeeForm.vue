<template>
<div>
  <div class="row">
    <div class="col-sm">
      <input placeholder="first name" name="first_name" v-model="data.first_name">
      <p class="error" v-if="this.errors.first_name">{{ this.errors.first_name[0] }}</p>
    </div>
    <div class="col-sm">
      <input placeholder="last name" name="last_name" v-model="data.last_name">
      <p class="error" v-if="this.errors.last_name">{{ this.errors.last_name[0] }}</p>
    </div>
  </div>
  <div class="row">
    <div class="col-sm">
      <input placeholder="gender" name="gender" v-model="data.gender">
      <p class="error" v-if="this.errors.gender">{{ this.errors.gender[0] }}</p>
    </div>
    <div class="col-sm">
      <input placeholder="ethnicity" name="ethnicity" v-model="data.ethnicity">
      <p class="error" v-if="this.errors.ethnicity">{{ this.errors.ethnicity[0] }}</p>
    </div>
  </div>
  <div class="row">
    <div class="col-sm">
      <input placeholder="school" name="school" v-model="data.school">
      <p class="error" v-if="this.errors.school">{{ this.errors.school[0] }}</p>
    </div>
    <div class="col-sm">
      <input placeholder="grade" name="grade" v-model="data.grade"
        type="number" min="6" max="12">
      <p class="error" v-if="this.errors.grade">{{ this.errors.grade[0] }}</p>
    </div>
  </div>
  <div class="row">
    <div class="col-sm">
      <input class="w-50" placeholder="referrer" name="referrer" v-model="data.referrer">
      <p class="error" v-if="this.errors.refeerrer">{{ this.errors.referrer[0] }}</p>
    </div>
  </div>
  <div class="row">
    <div class="col-sm d-flex justify-content-center">
      <label>
        <input name="role" v-model="data.role" value="attendee" type="radio">
        <span></span>
      </label>

      <label for="attendee">
        Attendee
      </label>
    </div>
    <div class="col-sm d-flex justify-content-center">
      <label>
        <input name="role" v-model="data.role" value="mentor" type="radio">
        <span></span>
      </label>

      <label for="mentor">
        Mentor
      </label>
    </div>
    <div class="col-sm d-flex justify-content-center">
      <label>
        <input name="role" v-model="data.role" value="teacher" type="radio">
        <span></span>
      </label>
      <label for="teacher">
        Teacher
      </label>
    </div>
  </div>
  <p v-if="this.errors.role">{{ this.errors.role[0] }}</p>
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
  _.zipObject(_.map(keyFunc, input), _.map(valFunc, input)),
)

const properties = [
  'firstname',
  'lastname',
  'gender',
  'ethnicity',
  'school',
  'grade',
  'referrer',
  'role',
]

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
        console.log(errors)

        this.errors = errors
      }
    },
  },
}
</script>
