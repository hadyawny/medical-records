// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalRecords {
    struct Record {
        uint256 appointmentDate;
        string doctorNotes;
        string diagnosis;
        string prescriptions;
        string followUpPlan;
        string doctorId;
    }

    mapping(string => Record[]) private records;

    function addRecord(
        string memory patientId,
        uint256 appointmentDate,
        string memory doctorNotes,
        string memory diagnosis,
        string memory prescriptions,
        string memory followUpPlan,
        string memory doctorId
    ) public {
        records[patientId].push(Record(appointmentDate, doctorNotes, diagnosis, prescriptions, followUpPlan, doctorId));
    }

    function getRecords(string memory patientId) public view returns (Record[] memory) {
        return records[patientId];
    }
}
