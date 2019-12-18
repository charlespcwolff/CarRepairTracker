<template>
    <section id="repair-lines">
        <table id="repair-table">
            <tr>
                <th>Description</th>
                <th>Time to Repair</th>
                <th>Cost</th>
                <th>Approved</th>
                <th v-if="isEmpOrAdmin"></th>
            </tr>
            <tr v-for="repairLine in repairLines" :key="repairLine.id">
                <td>{{repairLine.description}}</td>
                <td>{{repairLine.timeHours}} hours</td>
                <td>${{repairLine.cost}}</td>
                <td>
                    <button v-if="!isEmpOrAdmin && !repairLine.approved && !repairLine.declined" v-on:click="approveRepairLine(repairLine.id)">Approve</button>
                    <button v-if="!isEmpOrAdmin && !repairLine.approved && !repairLine.declined" v-on:click="declineRepairLine(repairLine.id)">Decline</button>
                    <p v-show="isEmpOrAdmin || repairLine.approved || repairLine.declined">{{approvedDeclinedMessage(repairLine.approved, repairLine.declined)}}</p>
                </td>
                <td><button v-if="isEmpOrAdmin">Edit</button></td>
            </tr>
        </table>
    </section>
</template>

<script>
import auth from '@/shared/auth';
import { APIService } from "@/shared/APIService"
const apiService = new APIService();

export default {
    name: "display-repair-lines",
    props: {
        incidentId: Number
    },
    data() {
        return {
            repairLines: []
        }
    },
    computed: {
        isEmpOrAdmin() {
            return auth.isEmpOrAdmin();
        },
        isAdmin() {
            return auth.isAdmin();
        }
    },
    methods: {
        async getRepairLines(id) {
            try {
                this.repairLines = await apiService.getRepairLines(id);
                this.calculateCosts();
            } catch (error) {
                this.error = error.message;
            }
        },
        async approveRepairLine(id) {
            try {
                const data = {
                    lineId: id
                };
                this.repairLines = await apiService.approveRepairLine(data);
                this.getRepairLines(this.incidentId);
            } catch (error) {
                this.error = error.message;
            }
        },
        async declineRepairLine(id) {
            try {
                const data = {
                    lineId: id
                };
                this.repairLines = await apiService.declineRepairLine(data);
                this.getRepairLines(this.incidentId);
            } catch (error) {
                this.error = error.message;
            }
        },
        approvedDeclinedMessage(approved, declined) {
            let message = "";

            if (declined) {
                message = "Declined";
            } else if (approved) {
                message = "Approved"
            } else {
                message = "Pending"
            }

            return message;
        },
        calculateCosts() {
            let costs = {
                possible: 0,
                approved: 0,
                hours: 0
            };
            this.repairLines.forEach(repairLine => {
                costs.possible += repairLine.cost;

                if (repairLine.approved) {
                    costs.approved += repairLine.cost;
                    costs.hours += repairLine.timeHours;
                }
            });

            this.$emit('updateCosts', costs);
        }
    },
    created() {
        this.getRepairLines(this.incidentId);
    }
}
</script>

<style scoped>

#repair-table {
    width: 100%;
}

</style>