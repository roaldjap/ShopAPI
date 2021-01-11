<template>
  <v-app id="app">
    <Navigation />
    <v-container>
      <h1>Sales Report</h1>
      <v-autocomplete
        filled
        rounded
        clearable
        auto-select-first
        v-model="apn_value"
        :items="list_apn_codes"
        label="APN Code"
        @change="getApiChartData()"
      ></v-autocomplete>

      <h2>Generated Report for: {{ apn_value }}</h2>
      <line-chart
        v-if="loaded"
        :chart-data="chartData"
        :options="options"
        :apn_value="apn_value"
      />
<!-- 
      <bar-chart
        v-if="loaded"
        :chart-data="chartData"
        :options="options"
        :apn_value="apn_value"
      /> -->
    </v-container>
  </v-app>
</template>

<script>
import Navigation from "./components/navigation.vue";
import axios from "axios";
import LineChart from "./components/chartjs/line-chart.vue";
import BarChart from "./components/chartjs/bar.vue";

export default {
  components: {
    Navigation,
    LineChart,
    BarChart
  },

  data: () => ({
    list_apn_codes: null,
    apn_value: null,
    loaded: false,
    chartData: null,
  }),

  mounted() {
    this.loaded = false;
    this.getApiChartData();
  },

  beforeMount() {
    axios
      .get(`/api/v1/get_apns`)
      .then((response) => {
        this.list_apn_codes = response.data;
      })
      .catch((error) => {
        console.log(error);
      });
  },

  methods: {
    getApiChartData() {
      this.lineChartData();
    },

    async barChartData() {
      if (this.apn_value === null) {
        console.log("trigger");
        this.chartData = {
          type: Object,
          default: null,
        };
        return false;
      }

      try {
        const response = await axios.get(
          "/api/v1/transactions/" + this.apn_value
        );
        const data = response.data;
        this.chartData = {
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
          datasets: data,
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
      }
    },

    async lineChartData() {
      if (this.apn_value === null) {
        console.log("trigger");
        this.chartData = {
          type: Object,
          default: null,
        };
        return false;
      }

      try {
        const response = await axios.get(
          "/api/v1/transactions/" + this.apn_value
        );
        const data = response.data;
        this.chartData = {
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
          datasets: data,
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
      }
    }
  },
};
</script>
