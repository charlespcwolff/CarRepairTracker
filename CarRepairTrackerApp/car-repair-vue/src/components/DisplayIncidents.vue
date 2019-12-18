<template>
    <div id="display-incidents">
        <router-link v-for="incident in incidents" :key="incident.id" v-bind:to="{ name: 'incident-details', params: { incident: incident } }" tag="div" class="incident">
            <div class="make" id="cardfield"><strong>Make</strong>: <br> {{incident.vehicle.make}}</div>
            <div class="model" id="cardfield"><strong>Model:</strong> <br>{{incident.vehicle.model}}</div>
            <div class="submitted" id="cardfield"><strong>Submitted:</strong> <br>{{submittedDateShort(incident.incident.submittedDate)}}</div>
            <div class="status" id="cardfield"><strong>Status:</strong> <br>{{incident.status}}</div>
        </router-link>
    </div>
</template>

<script>

export default {
    name: "display-incidents",
    components: {
    },
    props: {
        incidents: Array
    },
    methods: {
        submittedDateShort(date) {
            const dateTime = date.split("T");
            const unformatedDate = dateTime[0].split("-");
            const formatedDate = `${unformatedDate[1]}/${unformatedDate[2]}/${unformatedDate[0]}`;
            return formatedDate;
        },
    }
}
</script>

<style scoped>
.incident {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-areas: "make submitted"
                         "model status";
    margin-top: 8%;
    margin-bottom: 5%;
    padding-top: 3%;
    padding-bottom: 3%;
    border-radius: 8px;
    border-style: solid;
    border-width: 3px;
    border-color:maroon;
    box-shadow: 10px 10px 5px grey;
    box-sizing: content-box;
    width: 100%;
    background-color: darkgrey;
    height: auto;

}


.make {
    grid-area: make;
    padding-bottom: 2%;
     background-color: grey;
    text-decoration-color: white;
}

.submitted {
    grid-area: submitted;
   
  

}

.model {
    grid-area: model;
  
}

.status {
    grid-area: status;
  
    
}

#cardfield {
    text-transform: uppercase;
    -webkit-text-fill-color: white;
    background-color:darkgrey;

}
</style>