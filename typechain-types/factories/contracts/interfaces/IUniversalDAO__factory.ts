/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import type { Provider } from "@ethersproject/providers";
import type {
  IUniversalDAO,
  IUniversalDAOInterface,
} from "../../../contracts/interfaces/IUniversalDAO";

const _abi = [
  {
    inputs: [
      {
        internalType: "enum IUniversalDAO.UniversalDAOErrorCodes",
        name: "code",
        type: "uint8",
      },
    ],
    name: "UniversalDAOError",
    type: "error",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        indexed: true,
        internalType: "address",
        name: "admin",
        type: "address",
      },
      {
        indexed: false,
        internalType: "address",
        name: "token",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "minTokenHolding",
        type: "uint256",
      },
    ],
    name: "DAORegistered",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        indexed: false,
        internalType: "address",
        name: "token",
        type: "address",
      },
    ],
    name: "DaoTokenSet",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        indexed: true,
        internalType: "address",
        name: "member",
        type: "address",
      },
      {
        indexed: false,
        internalType: "bool",
        name: "setRole",
        type: "bool",
      },
    ],
    name: "MemberSet",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "minTokenHolding",
        type: "uint256",
      },
    ],
    name: "MinTokenHoldingSet",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "proposalId",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "string",
        name: "description",
        type: "string",
      },
    ],
    name: "ProposalCreated",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "proposalId",
        type: "uint256",
      },
      {
        indexed: true,
        internalType: "address",
        name: "voter",
        type: "address",
      },
    ],
    name: "Voted",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        internalType: "string",
        name: "description",
        type: "string",
      },
    ],
    name: "createProposal",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        internalType: "address",
        name: "admin",
        type: "address",
      },
      {
        internalType: "address",
        name: "token",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "minTokenHolding",
        type: "uint256",
      },
    ],
    name: "registerDAO",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        internalType: "address",
        name: "token",
        type: "address",
      },
    ],
    name: "setDaoToken",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        internalType: "address",
        name: "member",
        type: "address",
      },
      {
        internalType: "bool",
        name: "setRole",
        type: "bool",
      },
    ],
    name: "setMember",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        internalType: "uint256",
        name: "minTokenHolding",
        type: "uint256",
      },
    ],
    name: "setMinTokenHolding",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bool",
        name: "pause",
        type: "bool",
      },
    ],
    name: "setPause",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "daoId",
        type: "bytes32",
      },
      {
        internalType: "uint256",
        name: "proposalId",
        type: "uint256",
      },
    ],
    name: "vote",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

export class IUniversalDAO__factory {
  static readonly abi = _abi;
  static createInterface(): IUniversalDAOInterface {
    return new utils.Interface(_abi) as IUniversalDAOInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): IUniversalDAO {
    return new Contract(address, _abi, signerOrProvider) as IUniversalDAO;
  }
}
