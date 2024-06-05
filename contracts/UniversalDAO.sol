// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "./interfaces/IUniversalDAO.sol";

contract UniversalDAO is
    Initializable,
    OwnableUpgradeable,
    PausableUpgradeable,
    ReentrancyGuardUpgradeable,
    IUniversalDAO
{
    /// -----------------------------------------------------------------------
    /// Storage variable
    /// -----------------------------------------------------------------------

    /// @notice DAOs public info
    mapping(bytes32 => DAOInfo) public daos;

    /// -----------------------------------------------------------------------
    /// Modifier
    /// -----------------------------------------------------------------------

    /// @dev Modifier to check if the caller is admin of DAO
    /// @param _daoId DAO id
    modifier onlyAdmin(bytes32 _daoId) {
        if (msg.sender != daos[_daoId].admin) {
            revert UniversalDAOError(
                UniversalDAOErrorCodes.CALLER_IS_NOT_ADMIN
            );
        }
        _;
    }

    /// -----------------------------------------------------------------------
    /// Init
    /// -----------------------------------------------------------------------

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /// @notice Initialize
    function initialize() public initializer {
        __Ownable_init();
        __Pausable_init();
        __ReentrancyGuard_init();
    }

    /// -----------------------------------------------------------------------
    /// Configuration
    /// -----------------------------------------------------------------------

    /// @notice Inherit from IUniversalDAO
    function registerDAO(
        bytes32 _daoId,
        address _admin,
        address _token,
        uint256 _minTokenHolding
    ) external override {
        if (daos[_daoId].admin != address(0)) {
            revert UniversalDAOError(
                UniversalDAOErrorCodes.DAO_ALREADY_REGISTERED
            );
        }

        if (_token == address(0)) {
            revert UniversalDAOError(
                UniversalDAOErrorCodes.INVALID_TOKEN_ADDRESS
            );
        }

        daos[_daoId].admin = _admin;
        daos[_daoId].token = _token;
        daos[_daoId].minTokenHolding = _minTokenHolding;

        emit DAORegistered(_daoId, _admin, _token, _minTokenHolding);
    }

    /// -----------------------------------------------------------------------
    /// Create Proposal
    /// -----------------------------------------------------------------------

    /// @notice Inherit from IUniversalDAO
    function createProposal(
        bytes32 _daoId,
        string memory _description
    ) external override onlyAdmin(_daoId) {
        uint256 proposalId = daos[_daoId].proposalCount++;
        daos[_daoId].proposals[proposalId].description = _description;

        emit ProposalCreated(_daoId, proposalId, _description);
    }

    /// -----------------------------------------------------------------------
    /// Vote section
    /// -----------------------------------------------------------------------

    /// @notice Inherit from IUniversalDAO
    function vote(bytes32 _daoId, uint256 _proposalId) external override nonReentrant {
        DAOInfo storage dao = daos[_daoId];

        if (!dao.isMember[msg.sender]) {
            revert UniversalDAOError(
                UniversalDAOErrorCodes.CALLER_IS_NOT_MEMBER
            );
        }

        if (
            IERC20(dao.token).balanceOf(msg.sender) <
            daos[_daoId].minTokenHolding
        ) {
            revert UniversalDAOError(
                UniversalDAOErrorCodes.CALLER_DOES_NOT_HOLD_ENOUGH_TOKEN_TO_VOTE
            );
        }

        Proposal storage proposal = dao.proposals[_proposalId];

        if (proposal.voted[msg.sender]) {
            revert UniversalDAOError(UniversalDAOErrorCodes.ALREADY_VOTED);
        }

        proposal.voted[msg.sender] = true;
        proposal.voteCount++;

        emit Voted(_daoId, _proposalId, msg.sender);
    }

    /// -----------------------------------------------------------------------
    /// DAO Admin actions
    /// -----------------------------------------------------------------------

    /// @notice Inherit from IUniversalDAO
    function setMember(
        bytes32 _daoId,
        address _member,
        bool _setRole
    ) external override onlyAdmin(_daoId) nonReentrant {
        daos[_daoId].isMember[_member] = _setRole;

        emit MemberSet(_daoId, _member, _setRole);
    }

    /// @notice Inherit from IUniversalDAO
    function setDaoToken(
        bytes32 _daoId,
        address _token
    ) external override onlyAdmin(_daoId) nonReentrant {
        daos[_daoId].token = _token;

        emit DaoTokenSet(_daoId, _token);
    }

    /// @notice Inherit from IUniversalDAO
    function setMinTokenHolding(
        bytes32 _daoId,
        uint256 _minTokenHolding
    ) external override onlyAdmin(_daoId) nonReentrant {
        daos[_daoId].minTokenHolding = _minTokenHolding;

        emit MinTokenHoldingSet(_daoId, _minTokenHolding);
    }

    /// -----------------------------------------------------------------------
    /// Owner action
    /// -----------------------------------------------------------------------

    /// @notice Inherit from IUniversalDAO
    function setPause(bool _setPause) external override onlyOwner {
        if (_setPause) {
            _pause();
        } else {
            _unpause();
        }
    }
}
