<template>
  <div>
    <div class="d-flex justify-content-center h5 mt-5 mb-5">
      <a href="jonesjam.org/projects" class="disabled mr-5">all projects</a>
      <button @click="toggle" class="text-purple">help
        <svg v-if="helpExpanded" width="16" height="9" viewBox="0 0 16 9" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M0.923584 8.16504L7.61046 1.4783L14.2972 8.16504" stroke="#6461FF" stroke-width="2"/>
        </svg>
        <svg v-else width="16" height="10" viewBox="0 0 16 10" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M0.923584 1.47852L7.61046 8.16525L14.2972 1.47852" stroke="#6461FF" stroke-width="2"/>
        </svg>
      </button>
    </div>
    <div v-if="helpExpanded">
      <p>
        Create a cool visualization/game/whatever based on  the theme. There’s no limit on the size of your program, but programs that use less tokens rank higher.
      </p>
      <p>
        The only requirement is that your game have this function `draw` that accepts a 300x300&nbsp;<a href="https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API/Tutorial">canvas object</a>:
      </p>
      <pre><code>
function draw (canvas) {
    ...code...
}
      </code></pre>
      <p>
        <a href="https://twitter.com/hashtag/tweetcart?lang=en">Here's some inspiration.</a>
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MiddleSection',
  data: () => ({
    helpExpanded: true,
  }),
  methods: {
    toggle() {
      this.helpExpanded = !this.helpExpanded
    },
  },
}
</script>
