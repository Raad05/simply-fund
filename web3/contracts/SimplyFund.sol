// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

contract SimplyFund {
    // events
    event CampaignCreated(
        uint indexed campaignID,
        address indexed owner,
        string title
    );

    event DonatedFund(
        uint indexed campaignID,
        address indexed donator,
        uint amount
    );

    // structs
    struct Campaign {
        address owner;
        string title;
        string description;
        uint target;
        uint deadline;
        uint totalCollected;
        string image;
        address[] donators;
        uint[] donations;
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
            _image,
            new address[](0),
            new uint[](0)
        );
        require(
            newCampaign.deadline > block.timestamp,
            "Please enter a valid deadline."
        );

        campaigns[totalCampaigns] = newCampaign;

        uint campaignID = totalCampaigns;
        totalCampaigns++;

        emit CampaignCreated(campaignID, msg.sender, newCampaign.title);

        return true;
    }

    function donate(uint _id) public payable returns (bool) {
        Campaign storage campaign = campaigns[_id];
        campaign.donators.push(msg.sender);
        campaign.donations.push(msg.value);

        (bool sent, ) = campaign.owner.call{value: msg.value}("");
        require(sent, "Failed to donate to campaign.");

        campaign.totalCollected += msg.value;

        emit DonatedFund(_id, msg.sender, msg.value);

        return true;
    }

    // read operations

    // modifiers
}
