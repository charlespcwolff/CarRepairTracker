<template>
<b-row>
    <b-col cols="2"> </b-col>
    <b-col cols="10">
    <section id="incident-details">
        <div id="incident-header">
            <div id="customer-name">
                <div>Owner</div>
                <div>{{customer.firstName}} {{customer.lastName}}</div>
            </div>
            <div id="incident-id">
                <div>Incident Id</div>
                <div>{{incident.id}}</div>
            </div>
            <div id="vin">
                <div>Vin</div>
                <div>{{vehicle.vin}}</div>
            </div>
            <div id="submit-date">
                <div>Submitted Date</div>
                <div>{{submittedDateShort(incident.submittedDate)}}</div>
            </div>
            <div id="status">
                <div>Status</div>
                <div>{{status}}</div>
            </div>
            <div id="pickup">
                <div>Pickup Date</div>
                <div>{{incident.pickupdate}}</div>
            </div>
            <div id="make">
                <div>Make</div>
                <div>{{vehicle.make}}</div>
            </div>
             <div id="color">
                <div>Color</div>
                <div>{{vehicle.color}}</div>
            </div>
            <div id="year">
                <div>Year</div>
                <div>{{vehicle.year}}</div>
            </div>
            <div id="model">
                <div>Model</div>
                <div>{{vehicle.model}}</div>
            </div>
            <div id="description">
                <div>Description of Problem</div>
                <div>{{incident.description}}</div>
            </div>
        </div>
        <div v-if="isEmpOrAdmin" id="update-buttons">
        <!-- Dummy Buttons for Paid, Complete Buttons until methods are added -->    
            <button type="submit" class="btn btn-danger float-center">Paid</button>  
            <button type="submit" class="btn btn-secondary float-center">Complete</button>
        </div>
        <add-repair-line v-if="isEmpOrAdmin" :id="incident.id" @reload="reload"/>
        <display-repair-lines :incidentId ="incident.id" @updateCosts="updateCosts" ref="repairLines"/>

        <div v-show="isEmpOrAdmin" id="total-hours">Required {{totalHoursRequired}} Hours for Approved Items</div>
        
        <div id="cost-totals">
            <div class="cost"><p>Cost for Full Repairs:</p><p>${{costOfPossible}}</p></div>
            <div class="cost"><p>Cost of Approved Repairs:</p><p>${{costOfApproved}}</p></div>
            <div class="cost"><p>Remaining Balance:</p><p>${{remainingCost}}</p></div>
        </div>
    </section>
</b-col>
<b-col cols="2"></b-col>

</b-row>
</template>

<script>
import auth from '@/shared/auth';
import DisplayRepairLines from "@/components/DisplayRepairLines"
import AddRepairLine from "@/components/AddRepairLine"
import { APIService } from "@/shared/APIService"
const apiService = new APIService();

export default {
    name: "incident-details-info",
    components: {
        DisplayRepairLines, 
        AddRepairLine
    },
    data() {
        return {
            customer: {},
            payIncidentForm: {
                incidentId: "",
                CompletedByDate: ""
            },
            costOfPossible: 0,
            costOfApproved: 0,
            totalHoursRequired: 0
        }
    },
    props: {
        incident: Object,
        vehicle: Object,
        status: String
    },
    computed: {
        isEmpOrAdmin() {
            return auth.isEmpOrAdmin();
        },
        isAdmin() {
            return auth.isAdmin();
        },
        remainingCost() {
            if (this.incident.paid) {
                return 0;
            } else {
                return this.costOfApproved;
            }
        }
    },
    methods: {
        submittedDateShort(date) {
            const dateTime = date.split("T");
            const unformatedDate = dateTime[0].split("-");
            const formatedDate = `${unformatedDate[1]}/${unformatedDate[2]}/${unformatedDate[0]}`;
            return formatedDate;
        },
        async getCustomer() {
            try {
                this.customer = await apiService.getUserById(this.vehicle.userId);
            } catch (error) {
                this.error = error.message;
            }
        },
        async payIncident() {
            try {
                this.customer = await apiService.putPayIncident(this.payIncidentForm);
            } catch (error) {
                this.error = error.message;
            }
        },
        reload() {
            this.$refs.repairLines.getRepairLines(this.incident.id);
        },
        updateCosts(costs) {
            this.costOfPossible = costs.possible;
            this.costOfApproved = costs.approved;
            this.totalHoursRequired = costs.hours;
        }
    },
    created() {
        this.getCustomer();
    }
}
</script>

<style scoped>

#incident-details{

    padding-top: 15%;
}

#incident-header {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr 2fr 2fr 2fr;
    grid-template-areas: "name name incident submit status pickup"
                         "vin vin vin description description description"
                         "make make make  description description description"
                         "model color year description description description"
                         ". . . description description description";
}

#customer-name {
    grid-area: name;
}

#incident-id {
    grid-area: incident;
}

#vin {
    grid-area: vin;
}

#submit-date {
    grid-area: submit;
}

#status {
    grid-area: status;
}

#make {
    grid-area: make;
}

#model {
    grid-area: model;
}

#year {
    grid-area: year;
}

#color {
    grid-area: color;
}

#description {
    grid-area: description;
}

#pickup {
    grid-area: pickup;
}

.cost {
    display: flex;
}

</style>