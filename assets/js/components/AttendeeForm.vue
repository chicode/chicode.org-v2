<template>
  <div class="form">
    <div class="row">
      <div class="col-md-6">
        <input name="first_name" placeholder="first name" v-model="data.first_name"/>
        <p class="error" v-if="this.errors.first_name">{{ this.errors.first_name[0] }}</p>
      </div>
      <div class="col-md-6">
        <input name="last_name" placeholder="last name" v-model="data.last_name"/>
        <p class="error" v-if="this.errors.last_name">{{ this.errors.last_name[0] }}</p>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6">
        <input name="school" placeholder="school" v-model="data.school"/>
        <p class="error" v-if="this.errors.school">{{ this.errors.school[0] }}</p>
      </div>
      <div class="col-md-6">
        <input
                max="12"
                min="6"
                name="grade"
                placeholder="grade"
                type="number"
                v-model="data.grade"
        />
        <p class="error" v-if="this.errors.grade">{{ this.errors.grade[0] }}</p>
      </div>
    </div>
    <button @click="submit" class="mt-4">
      <img :src="this.image" class="d-inline-block"/>
      finish by signing in
    </button>
  </div>
</template>

<script>
import _ from 'lodash'

const toObject = _.curry((keyFunc, valFunc, input) =>
        _.zipObject(_.map(keyFunc, input), _.map(valFunc, input)),
);

const properties = ['firstname', 'lastname', 'school', 'grade'];

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
      this.data.head = 0
      this.data.torso = 0
      this.data.legs = 0
      this.data.role = 'student'
      const resp = await fetch('/', {
        method: 'post',
        body: JSON.stringify(this.data),
        headers: {
          'Content-Type': 'application/json',
        },
      });

      if (resp.status === 200) {
        window.location.href = this.successLocation
      } else {
        const {errors} = await resp.json();
        console.log(errors);

        this.errors = errors
      }
    },
  },
}
</script>
