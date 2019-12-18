<template>
    <b-container class="dashboard">

         <!-- Employee and Admin Nav -->
         <b-row class="text-center">
         <b-col v-if="isEmpOrAdmin" cols="2" >
            <b-button-group vertical>
              <b-button class="btn4">Pending Incident</b-button>
              <b-button class="btn4">Approved Incidents</b-button>
              <b-button class="btn4">In Progress</b-button>
              <b-button class="btn4">Completed</b-button>
              <b-button class="btn4">Work History</b-button>
              <b-button v-if="isAdmin" class="btn4">Employee Portal</b-button>   
            </b-button-group> 
        </b-col>
        <!-- Customer Nav -->
        <b-col v-if="!isEmpOrAdmin" cols="1"></b-col>
        <!-- Employee and Admin Display Incidents Area for Buttons Clicked in Nav -->
        <b-col cols="10" >     
            <router-link v-if="!isEmpOrAdmin" :to="{name:'new-incident'}" tag="b-button" class="btn1">New Incident</router-link>
            <div id="incidents">
            <display-incidents :incidents="incidents"/></div>    
         </b-col>
        <!-- Empty column. Do not use -->
        <b-col cols="1"></b-col>
         </b-row>
         
    </b-container>

</template>

<script>
import auth from '@/shared/auth';
import DisplayIncidents from "@/components/DisplayIncidents"
import { APIService } from "@/shared/APIService"
const apiService = new APIService();

export default {
    computed: {
        isEmpOrAdmin() {
            return auth.isEmpOrAdmin();
        },
        isAdmin() {
            return auth.isAdmin();
        }
    },
    name: "customer-incidents",
    components: {
        DisplayIncidents
    },
    data() {
        return {
            incidents: []
        }
    },
    methods: {
        async getCustomerIncidents() {
            try {
                this.incidents = await apiService.getUserIncidents();
            } catch (error) {
                this.error = error.message;
            }
        },
        async getIncidents() {
            try {
                this.incidents = await apiService.getIncidents();
            } catch (error) {
                this.error = error.message;
            }
        }
    },
    created() {
      if (!this.isEmpOrAdmin){
        this.getCustomerIncidents();
      } else {
        this.getIncidents();
      }
        
    },
    updated() {
      if (!this.isEmpOrAdmin){
        this.getCustomerIncidents();
      } else {
        this.getIncidents();
      }
    }
}
</script>

<style scoped>

.col-10{

  padding-top:12%;
}

.customer-incidents{
  border-color: red;
}

 .btn4 {
    border-radius: 0%;  
    padding-left: 5%;
    padding-right: 5%;
  }
@media only screen and (max-width: 500px) {
 
 .dashNav{
     width: 100%;

 }
  
 
 .btn1 {
   background-color: darkred;
    border-radius: 0%;  
    padding-left: 5%;
    padding-right: 5%;
  }
.btn1:hover{

  background-color:red;
}
}
@media only screen and (max-width: 768px){
  .col-10 {
      padding-top: 30%;
    
  }
}

</style>

