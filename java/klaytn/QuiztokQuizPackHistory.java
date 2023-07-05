package com.quiztok;

import com.klaytn.caver.Caver;
import com.klaytn.caver.crypto.KlayCredentials;
import com.klaytn.caver.methods.response.KlayLogs;
import com.klaytn.caver.methods.response.KlayTransactionReceipt;
import com.klaytn.caver.tx.SmartContract;
import com.klaytn.caver.tx.manager.TransactionManager;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.Callable;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.Address;
import org.web3j.abi.datatypes.Bool;
import org.web3j.abi.datatypes.Event;
import org.web3j.abi.datatypes.Function;
import org.web3j.abi.datatypes.Type;
import org.web3j.abi.datatypes.Utf8String;
import org.web3j.abi.datatypes.generated.Uint256;
import org.web3j.protocol.core.RemoteCall;
import org.web3j.tuples.generated.Tuple4;
import org.web3j.tx.gas.ContractGasProvider;

/**
 * <p>Auto generated smart contract code.
 * <p><strong>Do not modify!</strong>
 */
public class QuiztokQuizPackHistory extends SmartContract {
    private static final String BINARY = "60806040526100156001600160e01b0361006216565b600080546001600160a01b0319166001600160a01b03928316178082556040519216917f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0908290a3610066565b3390565b610b5b806100756000396000f3fe608060405234801561001057600080fd5b50600436106100625760003560e01c8063177234d11461006757806343d130791461022e5780638da5cb5b146102e45780638f32d59b146103085780639f158d5e14610324578063e3e658f414610560575b600080fd5b6100846004803603602081101561007d57600080fd5b5035610568565b6040518080602001806020018060200180602001858103855289818151815260200191508051906020019080838360005b838110156100cd5781810151838201526020016100b5565b50505050905090810190601f1680156100fa5780820380516001836020036101000a031916815260200191505b5085810384528851815288516020918201918a019080838360005b8381101561012d578181015183820152602001610115565b50505050905090810190601f16801561015a5780820380516001836020036101000a031916815260200191505b50858103835287518152875160209182019189019080838360005b8381101561018d578181015183820152602001610175565b50505050905090810190601f1680156101ba5780820380516001836020036101000a031916815260200191505b50858103825286518152865160209182019188019080838360005b838110156101ed5781810151838201526020016101d5565b50505050905090810190601f16801561021a5780820380516001836020036101000a031916815260200191505b509850505050505050505060405180910390f35b6102d26004803603602081101561024457600080fd5b810190602081018135600160201b81111561025e57600080fd5b82018360208201111561027057600080fd5b803590602001918460018302840111600160201b8311171561029157600080fd5b91908080601f0160208091040260200160405190810160405280939291908181526020018383808284376000920191909152509295506107d4945050505050565b60408051918252519081900360200190f35b6102ec61083e565b604080516001600160a01b039092168252519081900360200190f35b61031061084e565b604080519115158252519081900360200190f35b61055e600480360360a081101561033a57600080fd5b81359190810190604081016020820135600160201b81111561035b57600080fd5b82018360208201111561036d57600080fd5b803590602001918460018302840111600160201b8311171561038e57600080fd5b91908080601f0160208091040260200160405190810160405280939291908181526020018383808284376000920191909152509295949360208101935035915050600160201b8111156103e057600080fd5b8201836020820111156103f257600080fd5b803590602001918460018302840111600160201b8311171561041357600080fd5b91908080601f0160208091040260200160405190810160405280939291908181526020018383808284376000920191909152509295949360208101935035915050600160201b81111561046557600080fd5b82018360208201111561047757600080fd5b803590602001918460018302840111600160201b8311171561049857600080fd5b91908080601f0160208091040260200160405190810160405280939291908181526020018383808284376000920191909152509295949360208101935035915050600160201b8111156104ea57600080fd5b8201836020820111156104fc57600080fd5b803590602001918460018302840111600160201b8311171561051d57600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600092019190915250929550610872945050505050565b005b6102d2610a0f565b600081815260016020818152604092839020808301805485516002958216156101000260001901909116859004601f810185900485028201850190965285815260609586958695869594939185019260038601928692909186918301828280156106135780601f106105e857610100808354040283529160200191610613565b820191906000526020600020905b8154815290600101906020018083116105f657829003601f168201915b5050865460408051602060026001851615610100026000190190941693909304601f8101849004840282018401909252818152959950889450925084019050828280156106a15780601f10610676576101008083540402835291602001916106a1565b820191906000526020600020905b81548152906001019060200180831161068457829003601f168201915b5050855460408051602060026001851615610100026000190190941693909304601f81018490048402820184019092528181529598508794509250840190508282801561072f5780601f106107045761010080835404028352916020019161072f565b820191906000526020600020905b81548152906001019060200180831161071257829003601f168201915b5050845460408051602060026001851615610100026000190190941693909304601f8101849004840282018401909252818152959750869450925084019050828280156107bd5780601f10610792576101008083540402835291602001916107bd565b820191906000526020600020905b8154815290600101906020018083116107a057829003601f168201915b505050505090509450945094509450509193509193565b6000806003836040518082805190602001908083835b602083106108095780518252601f1990920191602091820191016107ea565b51815160209384036101000a600019018019909216911617905292019485525060405193849003019092205495945050505050565b6000546001600160a01b03165b90565b600080546001600160a01b0316610863610a15565b6001600160a01b031614905090565b61087a61084e565b6108cb576040805162461bcd60e51b815260206004820181905260248201527f4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e6572604482015290519081900360640190fd5b60008581526001602081815260409092208651889391926108f3929084019190890190610a19565b5084516109099060028301906020880190610a19565b50835161091f9060038301906020870190610a19565b5082516109329082906020860190610a19565b5060028054600181810180845560008490528454909385936004027f405787fa12a823e0f2b7631cc41b3ba8828b3321ca811111fa75cd3aa3bb5ace019261098d928492869261010090831615026000190190911604610a97565b50600182018160010190805460018160011615610100020316600290046109b5929190610a97565b50600282810180546109da928481019291600019610100600183161502011604610a97565b5060038201816003019080546001816001161561010002031660029004610a02929190610a97565b5050505050505050505050565b60025490565b3390565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f10610a5a57805160ff1916838001178555610a87565b82800160010185558215610a87579182015b82811115610a87578251825591602001919060010190610a6c565b50610a93929150610b0c565b5090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f10610ad05780548555610a87565b82800160010185558215610a8757600052602060002091601f016020900482015b82811115610a87578254825591600101919060010190610af1565b61084b91905b80821115610a935760008155600101610b1256fea265627a7a7231582085c56c44f05f75dd408a7e4fdae60e9ce279371fcb84006f33a2e8b69246854164736f6c63430005110032";

    public static final String FUNC_GETQUIZPACKSBYTXHASH = "getQuizPacksByTxHash";

    public static final String FUNC_GETQUIZPACKSCOUNT = "getQuizPacksCount";

    public static final String FUNC_GETQUIZPACKSINFO = "getQuizPacksInfo";

    public static final String FUNC_ISOWNER = "isOwner";

    public static final String FUNC_OWNER = "owner";

    public static final String FUNC_REGISTERQUIZPACKINFO = "registerQuizPackInfo";

    public static final Event OWNERSHIPTRANSFERRED_EVENT = new Event("OwnershipTransferred", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Address>(true) {}, new TypeReference<Address>(true) {}));
    ;

    protected QuiztokQuizPackHistory(String contractAddress, Caver caver, KlayCredentials credentials, int chainId, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, caver, credentials, chainId, contractGasProvider);
    }

    protected QuiztokQuizPackHistory(String contractAddress, Caver caver, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, caver, transactionManager, contractGasProvider);
    }

    public List<OwnershipTransferredEventResponse> getOwnershipTransferredEvents(KlayTransactionReceipt.TransactionReceipt transactionReceipt) {
        List<SmartContract.EventValuesWithLog> valueList = extractEventParametersWithLog(OWNERSHIPTRANSFERRED_EVENT, transactionReceipt);
        ArrayList<OwnershipTransferredEventResponse> responses = new ArrayList<OwnershipTransferredEventResponse>(valueList.size());
        for (SmartContract.EventValuesWithLog eventValues : valueList) {
            OwnershipTransferredEventResponse typedResponse = new OwnershipTransferredEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.previousOwner = (String) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.newOwner = (String) eventValues.getIndexedValues().get(1).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public RemoteCall<BigInteger> getQuizPacksByTxHash(String _txHash) {
        final Function function = new Function(FUNC_GETQUIZPACKSBYTXHASH, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Utf8String(_txHash)), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Uint256>() {}));
        return executeRemoteCallSingleValueReturn(function, BigInteger.class);
    }

    public RemoteCall<BigInteger> getQuizPacksCount() {
        final Function function = new Function(FUNC_GETQUIZPACKSCOUNT, 
                Arrays.<Type>asList(), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Uint256>() {}));
        return executeRemoteCallSingleValueReturn(function, BigInteger.class);
    }

    public RemoteCall<Tuple4<String, String, String, String>> getQuizPacksInfo(BigInteger id) {
        final Function function = new Function(FUNC_GETQUIZPACKSINFO, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.generated.Uint256(id)), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Utf8String>() {}, new TypeReference<Utf8String>() {}, new TypeReference<Utf8String>() {}, new TypeReference<Utf8String>() {}));
        return new RemoteCall<Tuple4<String, String, String, String>>(
                new Callable<Tuple4<String, String, String, String>>() {
                    @Override
                    public Tuple4<String, String, String, String> call() throws Exception {
                        List<Type> results = executeCallMultipleValueReturn(function);
                        return new Tuple4<String, String, String, String>(
                                (String) results.get(0).getValue(), 
                                (String) results.get(1).getValue(), 
                                (String) results.get(2).getValue(), 
                                (String) results.get(3).getValue());
                    }
                });
    }

    public RemoteCall<Boolean> isOwner() {
        final Function function = new Function(FUNC_ISOWNER, 
                Arrays.<Type>asList(), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Bool>() {}));
        return executeRemoteCallSingleValueReturn(function, Boolean.class);
    }

    public RemoteCall<String> owner() {
        final Function function = new Function(FUNC_OWNER, 
                Arrays.<Type>asList(), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteCall<KlayTransactionReceipt.TransactionReceipt> registerQuizPackInfo(BigInteger _id, String _quizPackName, String _quizPackType, String _quizPackTag, String _wallet) {
        final Function function = new Function(
                FUNC_REGISTERQUIZPACKINFO, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.generated.Uint256(_id), 
                new org.web3j.abi.datatypes.Utf8String(_quizPackName), 
                new org.web3j.abi.datatypes.Utf8String(_quizPackType), 
                new org.web3j.abi.datatypes.Utf8String(_quizPackTag), 
                new org.web3j.abi.datatypes.Utf8String(_wallet)), 
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public static QuiztokQuizPackHistory load(String contractAddress, Caver caver, KlayCredentials credentials, int chainId, ContractGasProvider contractGasProvider) {
        return new QuiztokQuizPackHistory(contractAddress, caver, credentials, chainId, contractGasProvider);
    }

    public static QuiztokQuizPackHistory load(String contractAddress, Caver caver, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return new QuiztokQuizPackHistory(contractAddress, caver, transactionManager, contractGasProvider);
    }

    public static RemoteCall<QuiztokQuizPackHistory> deploy(Caver caver, KlayCredentials credentials, int chainId, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(QuiztokQuizPackHistory.class, caver, credentials, chainId, contractGasProvider, BINARY, "");
    }

    public static RemoteCall<QuiztokQuizPackHistory> deploy(Caver caver, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(QuiztokQuizPackHistory.class, caver, transactionManager, contractGasProvider, BINARY, "");
    }

    public static class OwnershipTransferredEventResponse {
        public KlayLogs.Log log;

        public String previousOwner;

        public String newOwner;
    }
}
