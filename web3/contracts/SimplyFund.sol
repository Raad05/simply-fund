// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract SimplyFund {
    // events
    event CampaignCreated(string title);

    // structs
    struct Campaign {
        address owner;
        string title;
        string description;
        uint target;
        uint deadline;
        uint totalCollected;
        string image;
    }

    // state variables
    uint public totalCampaigns;

    // mappings
    mapping(uint => Campaign) public campaigns;

    // write operations
    function createCampaign(
        string memory _title,
        string memory _description,
        uint _target,
        uint _deadline,
        string memory _image
    ) public returns (bool) {
        Campaign memory newCampaign = Campaign(
            msg.sender,
            _title,
            _description,
            _target,
            _deadline,
            0,
            _image
        );
        require(
            newCampaign.deadline < block.timestamp,
            "Please enter a valid deadline."
        );

        campaigns[totalCampaigns] = newCampaign;
        totalCampaigns++;

        emit CampaignCreated(newCampaign.title);

        return true;
    }

    // read operations

    // modifiers
}
