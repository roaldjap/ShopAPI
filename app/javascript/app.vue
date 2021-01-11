<template>
  <v-app id="app">
    <Navigation />
    <v-container>
      <h1>Sales Report</h1>
      <!-- <v-autocomplete
        filled
        rounded
        v-model="apn_value"
        :items="apn_codes"
        label="APN Code"
      /> -->

      <h2>Generated Report for: {{ apn_value }}</h2>
      <line-chart v-if="loaded" :chartdata="chartdata" :options="options" />
    </v-container>
  </v-app>
</template>

<script>
import Navigation from "./components/navigation.vue";
import axios from "axios";
import LineChart from "./components/chartjs/line-chart.vue";

export default {
  components: {
    Navigation,
    LineChart,
  },

  data: () => ({
    message: "Hello Test!!",
    apn_codes: null,
    apn_value: null,
    loaded: false,
  }),

  async mounted() {
    this.loaded = false;
    try {
      const { apns } = await fetch("/api/v1/transactions/2770000000062");
      // this.chartdata = apns
      this.chartdata = {
        labels: [
          "January",
          "February",
          "March",
          "April",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        ], // Months
        datasets: [
          {
            label: "2005", // Years
            backgroundColor: this.getRandomColor(), // random
            data: [4, 3, 4, 1, 7, 12, 1, 7, 1, 11, 1, 3], // profit
          },
          {
            label: "2006", // Years
            backgroundColor: this.getRandomColor(), // random
            data: [4, 3, 4, 1, 7, 12, 1, 7, 1, 11, 1, 3], // profit
          },
          {
            label: "2007", // Years
            backgroundColor: this.getRandomColor(), // random
            data: [40, 20, 29], // profit
          },
          {
            label: "Data One", // Years
            backgroundColor: this.getRandomColor(), // random
            data: [40, 20], // profit
          },
        ],
      };
      this.options = {
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true,
              },
              gridLines: {
                display: true,
              },
            },
          ],
          xAxes: [
            {
              gridLines: {
                display: false,
              },
            },
          ],
        },
        legend: {
          display: true,
        },
        responsive: true,
        maintainAspectRatio: false,
      };
      this.loaded = true;
    } catch (e) {
      console.log(e);
    }
  },

  beforeMount() {
    axios
      .get(`/api/v1/get_apns`)
      .then((response) => {
        this.apn_codes = response.data;
      })
      .catch((error) => {
        console.log(error);
      });
  },

  methods: {
    getRandomColor() {
      var letters = "0123456789ABCDEF".split("");
      var color = "#";
      for (var i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
      }
      return color;
    },
  },
};
</script>
