unit web3.transaction;

{$MODESWITCH EXTERNALCLASS}

interface

uses
  // pas2js
  JS,
  // web3
  web3.blocks, web3.misc;

type
  TSignature = class external name 'ethers.Signature'(TJSObject);

  TTransactionReceipt = class; // forward declaration

  // TTransactionResponse includes all properties about a transaction that was sent to the network, which may or may not be included in a block.
  TTransactionResponse = class external name 'ethers.TransactionResponse'(TJSObject)
  strict private
    FBlockHash           : string;     external name 'blockHash';
    FBlockNumber         : UInt64;     external name 'blockNumber';
    FChainId             : TBigInt;    external name 'chainId';
    FData                : string;     external name 'data';
    FFrom                : string;     external name 'from';
    FGasLimit            : TBigInt;    external name 'gasLimit';
    FGasPrice            : TWei;       external name 'gasPrice';
    FHash                : string;     external name 'hash';
    FIndex               : UInt64;     external name 'index';
    FMaxFeePerGas        : TWei;       external name 'maxFeePerGas';
    FMaxPriorityFeePerGas: TWei;       external name 'maxPriorityFeePerGas';
    FNonce               : UInt64;     external name 'nonce';
    FSignature           : TSignature; external name 'signature';
    FTo                  : string;     external name 'to';
    FType                : UInt8;      external name 'type';
    FValue               : TWei;       external name 'value';
  public
    {-------------------------------- methods ---------------------------------}
    // Resolves to the number of confirmations this transaction has.
    function Confirmations: UInt64; async; external name 'confirmations';
    // Resolves to the block that this transaction was included in. This will return null if the transaction has not been included yet.
    function GetBlock: TBlock; async; external name 'getBlock';
    // Resolves to this transaction being re-requested from the provider.
    // This can be used if you have an unmined transaction and wish to get an up-to-date populated instance.
    function GetTransaction: TTransactionResponse; async; external name 'getTransaction';
    // Returns True if the transaction is a Berlin (i.e. type == 1) transaction.
    function IsBerlin: Boolean; external name 'isBerlin';
    // Returns True if the transaction is a Cancun (i.e. type == 3) transaction.
    function IsCancun: Boolean; external name 'isCancun';
    // Returns True if the transaction is a legacy (i.e. type == 0) transaction.
    function IsLegacy: Boolean; external name 'isLegacy';
    // Returns True if the transaction is a London (i.e. type == 2) transaction.
    function IsLondon: Boolean; external name 'isLondon';
    // Returns True if this transaction has been included with a block. This is effective only as of the time the TTransactionResponse was instantiated.
    function IsMined: Boolean; external name 'isMined';
    // Resolves once this transaction has been mined.
    function Wait: TTransactionReceipt; async; external name 'wait';
    {------------------------------- properties -------------------------------}
    // The blockHash of the block that this transaction was included in. This is "null" for pending transactions.
    property BlockHash: string read FBlockHash;
    // The block number of the block that this transaction was included in. This is "null" for pending transactions.
    property BlockNumber: UInt64 read FBlockNumber;
    // The chain ID, see: chainlist.org
    property ChainId: TBigInt read FChainId;
    // The transaction data.
    property Data: string read FData;
    // The sender of this transaction.
    property From: string read FFrom;
    // The maximum units of gas this transaction can consume. If execution exceeds this, the transaction is reverted and the sender is charged for the full amount, despite no state changes being made.
    property GasLimit: TBigInt read FGasLimit;
    // The gas price can have various values, depending on the network.
    // In modern networks, for transactions that are included this is the effective gas price (the fee per gas that was actually charged), while for transactions that have not been included yet is the maxFeePerGas.
    // For legacy transactions, or transactions on legacy networks, this is the fee that will be charged per unit of gas the transaction consumes.
    property GasPrice: TWei read FGasPrice;
    // The transaction hash.
    property Hash: string read FHash;
    // The index within the block that this transaction resides at.
    property Index: UInt64 read FIndex;
    // The maximum fee (per unit of gas) to allow this transaction to charge the sender.
    property MaxFeePerGas: TWei read FMaxFeePerGas;
    // The maximum priority fee (per unit of gas) to allow a validator to charge the sender.
    property MaxPriorityFeePerGas: TWei read FMaxPriorityFeePerGas;
    // The nonce, which is used to prevent replay attacks and offer a method to ensure transactions from a given sender are explicitly ordered.
    // When sending a transaction, this must be equal to the number of transactions ever sent by the sender.
    property Nonce: UInt64 read FNonce;
    // The signature for this transaction.
    property Signature: TSignature read FSignature;
    // The receiver of this transaction.
    property &To: string read FTo;
    // The EIP-2718 transaction envelope type. This is 0 for legacy transactions types.
    property &Type: UInt8 read FType;
    // The value of this transaction in wei.
    property Value: TWei read FValue;
  end;

  // TTransactionReceipt includes additional information about a transaction that is only available after it has been mined.
  TTransactionReceipt = class external name 'ethers.TransactionReceipt'(TJSObject)
  strict private
    FBlockHash        : string;  external name 'blockHash';
    FBlockNumber      : UInt64;  external name 'blockNumber';
    FContractAddress  : string;  external name 'contractAddress';
    FCumulativeGasUsed: TBigInt; external name 'cumulativeGasUsed';
    FFee              : TWei;    external name 'fee';
    FFrom             : string;  external name 'from';
    FGasPrice         : TWei;    external name 'gasPrice';
    FGasUsed          : TBigInt; external name 'gasUsed';
    FHash             : string;  external name 'hash';
    FIndex            : UInt64;  external name 'index';
    FStatus           : UInt8;   external name 'status';
    FTo               : string;  external name 'to';
    FType             : UInt8;   external name 'type';
  public
    {-------------------------------- methods ---------------------------------}
    // Resolves to the number of confirmations this transaction has.
    function Confirmations: UInt64; async; external name 'confirmations';
    // Resolves to the block this transaction occurred in.
    function GetBlock: TBlock; async; external name 'getBlock';
    // Resolves to the transaction this transaction occurred in.
    function GetTransaction: TTransactionResponse; async; external name 'getTransaction';
    {------------------------------- properties -------------------------------}
    // The block hash of the block this transaction was included in.
    property BlockHash: string read FBlockHash;
    // The block number of the block this transaction was included in.
    property BlockNumber: UInt64 read FBlockNumber;
    // The address of the contract if the transaction was directly responsible for deploying one.
    property ContractAddress: string read FContractAddress;
    // The amount of gas used by all transactions within the block for this and all transactions with a lower index.
    property CumulativeGasUsed: TBigInt read FCumulativeGasUsed;
    // The total fee for this transaction, in wei.
    property Fee: TWei read FFee;
    // The sender of the transaction.
    property From: string read FFrom;
    // The actual gas price used during execution.
    // Due to the complexity of EIP-1559 this value can only be calculated after the transaction has been mined, since the base fee is protocol-enforced.
    property GasPrice: TWei read FGasPrice;
    // The actual amount of gas used by this transaction.
    property GasUsed: TBigInt read FGasUsed;
    // The transaction hash.
    property Hash: string read FHash;
    // The index of this transaction within the block.
    property Index: UInt64 read FIndex;
    // The status of this transaction, indicating success (i.e. 1) or a revert (i.e. 0)
    property Status: UInt8 read FStatus;
    // The address the transaction was sent to.
    property &To: string read FTo;
    // The EIP-2718 transaction type.
    property &Type: UInt8 read FType;
  end;

function Transaction(const &to: string; const value: TWei; const data: string = '0x'): TJSObject;

implementation

function Transaction(const &to: string; const value: TWei; const data: string): TJSObject;
begin
  Result := TJSObject.New;
  Result['to']    := &to;
  Result['value'] := value;
  Result['data']  := data;
end;

end.
