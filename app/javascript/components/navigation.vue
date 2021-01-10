<template>
  <v-card tile class="overflow-hidden">
    <v-app-bar color="deep-purple accent-4" dark>
      <v-app-bar-nav-icon :href=link.path @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
    </v-app-bar>
  </v-card>
</template>

<script>
export default {
  data: () => ({
    link: {
      path: "/",
      text: "Home",
      id: 1,
    },
  }),

  watch: {
    group() {
      this.drawer = false;
    },
  },
};
</script>