// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IUniversalDAO {
    /// -----------------------------------------------------------------------
    /// Struct
    /// -----------------------------------------------------------------------

    /// @dev DAO info struct
    /// @param admin DAO admin address
    /// @param token DAO token address
    /// @param minTokenHolding Minimum token amount users should hold to vote
    /// @param isMember Mapping value if caller is member or not
    /// @param proposals Proposal info based on proposal Id
    /// @param proposalCount Total proposal count
    struct DAOInfo {
        address admin;
        address token;
        uint256 minTokenHolding;
        mapping(address => bool) isMember;
        mapping(uint256 => Proposal) proposals;
        uint256 proposalCount;
    }

    /// @dev Proposal info struct
    /// @param description Proposal description
    /// @param voteCount Total vote count which users participated
    /// @param voted Mapping value if caller voted or not
    struct Proposal {
        string description;
        uint256 voteCount;
        mapping(address => bool) voted;
    }

    /// -----------------------------------------------------------------------
    /// Errors
    /// -----------------------------------------------------------------------

    enum UniversalDAOErrorCodes {
        DAO_ALREADY_REGISTERED,
        INVALID_TOKEN_ADDRESS,
        CALLER_IS_NOT_MEMBER,
        CALLER_IS_NOT_ADMIN,
        CALLER_DOES_NOT_HOLD_ENOUGH_TOKEN_TO_VOTE,
        ALREADY_VOTED
    }

    error UniversalDAOError(UniversalDAOErrorCodes code);

    /// -----------------------------------------------------------------------
    /// Events
    /// -----------------------------------------------------------------------

    /// @dev The event is emitted when a new DAO has registered.
    /// @param daoId DAO id
    /// @param admin DAO admin address
    /// @param token DAO token address
    /// @param minTokenHolding Minimum token holding amount for voter
    event DAORegistered(
        bytes32 indexed daoId,
        address indexed admin,
        address token,
        uint256 minTokenHolding
    );

    /// @dev The event is emitted when a new proposal has created.
    /// @param daoId DAO id
    /// @param proposalId Proposal id
    /// @param description Proposal description
    event ProposalCreated(
        bytes32 indexed daoId,
        uint256 proposalId,
        string description
    );

    /// @dev The event is emitted when a user has voted.
    /// @param daoId DAO id
    /// @param proposalId Proposal id
    /// @param voter Voter address
    event Voted(
        bytes32 indexed daoId,
        uint256 proposalId,
        address indexed voter
    );

    /// @dev The event is emitted when DAO admin sets the member of DAO.
    /// @param daoId DAO id
    /// @param member Member address
    /// @param setRole Boolean value to set the role of member
    event MemberSet(
        bytes32 indexed daoId,
        address indexed member,
        bool setRole
    );

    /// @dev The event is emitted when DAO admin sets the DAO token.
    /// @param daoId DAO id
    /// @param token DAO token address
    event DaoTokenSet(bytes32 indexed daoId, address token);

    /// @dev The event is emitted when DAO admin sets the minimum token holding for voter.
    /// @param daoId DAO id
    /// @param minTokenHolding Minimum token holding amount
    event MinTokenHoldingSet(bytes32 indexed daoId, uint256 minTokenHolding);

    /// -----------------------------------------------------------------------
    /// Configuration
    /// -----------------------------------------------------------------------

    /// @dev Admin registers a new DAO.
    /// @param daoId DAO id
    /// @param admin DAO admin address
    /// @param token DAO token address
    /// @param minTokenHolding Minimum token holding amount for voter
    function registerDAO(
        bytes32 daoId,
        address admin,
        address token,
        uint256 minTokenHolding
    ) external;

    /// -----------------------------------------------------------------------
    /// Create Proposal
    /// -----------------------------------------------------------------------

    /// @dev Admin creates a new proposal.
    /// @param daoId DAO id
    /// @param description Proposal description
    function createProposal(bytes32 daoId, string memory description) external;

    /// -----------------------------------------------------------------------
    /// Vote section
    /// -----------------------------------------------------------------------

    /// @dev User votes to the proposal.
    /// @param daoId DAO id
    /// @param proposalId Proposal id
    function vote(bytes32 daoId, uint256 proposalId) external;

    /// -----------------------------------------------------------------------
    /// DAO Admin actions
    /// -----------------------------------------------------------------------

    /// @dev DAO admin sets or remove the member who can participate the voting.
    /// @param daoId DAO id
    /// @param member Member address
    /// @param setRole Boolean value to set the role of member
    function setMember(bytes32 daoId, address member, bool setRole) external;

    /// @dev DAO admin sets or updates the DAO token.
    /// @param daoId DAO id
    /// @param token DAO token address
    function setDaoToken(bytes32 daoId, address token) external;

    /// @dev DAO admin sets the minimum token holdings for voter.
    /// @param daoId DAO id
    /// @param minTokenHolding Minimum token holding amount
    function setMinTokenHolding(
        bytes32 daoId,
        uint256 minTokenHolding
    ) external;

    /// -----------------------------------------------------------------------
    /// Owner action
    /// -----------------------------------------------------------------------

    /// @dev Set pause and unpause of the contract.
    /// @dev This function can only called through protocol admin contract
    /// @param pause Bool value to represent pause and unpause state
    function setPause(bool pause) external;
}
