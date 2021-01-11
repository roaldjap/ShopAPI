<template>
  <v-app id="app">
    <Navigation />
    <v-container>
      <h1>Sales Report</h1>
      <v-autocomplete
        filled
        rounded
        v-model="apn_value"
        :items="apn_codes"
        label="APN Code"
        v-on:change="getApiChartData()"
      />

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

  mounted() {
    this.loaded = false;
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
    async getApiChartData() {
      console.log(this.apn_value);
      try {
        const { apns } = await fetch("/api/v1/transactions/#{this.apn_value}");
        this.chartdata = {
          labels: [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
          ], // Months
          datasets: [
            // Sample data only
            {
              label: "2005", // Years
              backgroundColor: this.getRandomColor(), // random
              data: [4, 3, 4, 1, 7, 12, 1, 7, 1, 11, 1, 3], // profit
            },
            {
              label: "2006", // Years
              backgroundColor: this.getRandomColor(), // random
              data: [0, 1, 4, 1, 5, 6, 9, 7, 5, 2, 1, 3], // profit
            },
            {
              label: "2007", // Years
              backgroundColor: this.getRandomColor(), // random
              data: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], // profit
            },
          ],
        };
        this.options = {
          scales: {
            yAxes: [
              {
                scaleLabel: {
                  display: true,
                  labelString: "Net Sales (ex total tax)",
                },
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
                scaleLabel: {
                  display: true,
                  labelString: "Months",
                },
                gridLines: {
                  display: true,
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
        console.log("No data available or Incorrect input");
        LineChart.destroy(); // destroy
      }
    },

    getRandomColor() {
      var letters = "0123456789ABCDEF".split("");
      var color = "#E6";
      for (var i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
      }
      return color;
    },
  },
};
</script>
