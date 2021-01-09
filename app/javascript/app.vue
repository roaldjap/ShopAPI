<template>
  <v-app id="app">
      <Navigation />
      <h1>Sales Report</h1>
      <p>{{ message }}</p>
  </v-app>
</template>

<script>
import Navigation from "./components/navigation.vue";
export default {
  data: function() {
    return {
      message: "Hello Tes!!",
    };
  },
  components: {
    Navigation: Navigation,
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
