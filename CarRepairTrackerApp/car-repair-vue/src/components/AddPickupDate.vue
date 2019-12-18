<template>
   <div>
       <button v-on:click="ItemFormShow = !ItemFormShow" type="submit" class="btn btn-primary float-center">Mark Paid & Add Pickup Date</button>
    <form v-on:submit.prevent="payIncident" class="rgForm">
        <div v-if="ItemFormShow">
            <div class="form-group">
                <label for="date">Date</label>
                <input
                type="Date"
                class="pickup-date"
                id="description"
                placeholder="Please enter date"
                v-model.trim="payIncidentForm.CompletedByDate">
            </div>
            <button type="submit" class="btn btn-primary float-center">Submit Pickup Date</button>
        </div>
        </form>
    </div>
</template>

<script> 
import { APIService } from "@/shared/APIService";
const apiService = new APIService();

export default {
    name: "add-pickup-date",
    data() {
        return {
            payIncidentForm:{
                CompletedByDate: Date,
                incidentId: ""
            },
            ItemFormShow: false, 
        }
    },
    props:{
        id : Number
    },
    methods: {
        async payIncident() {
            try {
                this.customer = await apiService.putPayIncident(this.payIncidentForm);
            } catch (error) {
                this.error = error.message;
            }
        }
    },
    created() {
        this.payIncidentForm.incidentId = this.id;
    }
}
</script>

<style scoped>

.form-group {
  justify-content: center;  
  align-content: center;
}
.btn {

    font-size: 100%;
  }
</style>