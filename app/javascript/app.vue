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

      <h2 v-if="loaded">Trend Report for: {{ apn_value }}</h2>
      <line-chart
        v-if="loaded"
        :chart-data="chartData"
        :options="options"
        :apn_value="apn_value"
      />
      <h2 v-if="loaded">Annual Report for: {{ apn_value }}</h2>
      <bar-chart
        v-if="loaded"
        :chart-data="barData"
        :options="options"
        :apn_value="apn_value"
      />
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
    BarChart,
  },

  data: () => ({
    list_apn_codes: null,
    apn_value: null,
    loaded: true,
    chartData: null,
    barData: null,
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
    async barChartData() {
      if (this.apn_value === null) {
        console.log("trigger bar");
        this.barData = {
          type: Object,
          default: null,
        };
        this.loaded = false
        return false;
      }

      try {
        const response = await axios.get(
          "/api/v1/annual-transactions/" + this.apn_value
        );

        const data = response.data;
        this.barData = data;
        this.options = {
          scales: {
            yAxes: [
              {
                scaleLabel: {
                  display: true,
                  labelString: "Gross Sales (Annual Net + Tax)",
                },
              },
            ],
            xAxes: [
              {
                scaleLabel: {
                  display: true,
                  labelString: "Years",
                },
                gridLines: {
                  display: true,
                },
              },
            ],
          },
          legend: {
            display: false,
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
        this.loaded = false
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
          ],
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

    getApiChartData() {
      this.lineChartData();
      this.barChartData();
    },
  },
};
</script>
