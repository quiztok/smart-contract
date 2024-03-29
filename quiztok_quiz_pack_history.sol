pragma solidity ^0.5.1;



library SafeMath {
 
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }
 
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }
 
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }
 
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}




contract Context {
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; 
        return msg.data;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }
}


contract QuiztokQuizPackHistory is Ownable{

    struct quizPacksInfo{
        string wallet; // 지갑 주소
        string quizPackName;
        string quizPackType;
        string quizPackTag;
    }

    mapping(uint256 => quizPacksInfo) quizPacksInfos;
    mapping(string => quizPacksInfo[]) userQuizPacksInfos;
    quizPacksInfo[] private quizPacksInfoDatas;

    function getQuizPacksInfo(uint256 num ) public view returns(string memory, string memory, string memory , string memory){ // 퀴즈 팩 정보 조회  
        quizPacksInfo storage r = quizPacksInfos[num];
        return(r.quizPackName, r.quizPackType, r.quizPackTag , r.wallet);
    }

    function registerQuizPackInfo(uint256 num, string memory quizPackName, string memory quizPackType , string memory quizPackTag, string memory wallet ) public onlyOwner { // 퀴즈팩 정보 등록 
                                   
        quizPacksInfo storage newQuizPacksInfo = quizPacksInfos[num];
        newQuizPacksInfo.quizPackName = quizPackName;
        newQuizPacksInfo.quizPackType = quizPackType;
        newQuizPacksInfo.quizPackTag = quizPackTag;
        newQuizPacksInfo.wallet = wallet; 
        quizPacksInfoDatas.push(newQuizPacksInfo);
        userQuizPacksInfos[wallet].push(newQuizPacksInfo);

    }

    function getQuizPacksCount() public view returns(uint256){ //퀴즈팩 총 풀이 수 
        return quizPacksInfoDatas.length;
    }

    function getUserQuizPackCount(string memory wallet) public view returns(uint256){ // 사용자 별 퀴즈팩 풀이 수 
        return userQuizPacksInfos[wallet].length; 
    }

    function getUserQuizPackInfo(string memory wallet, uint256  num) public view returns(string memory, string memory, string memory, string memory ){ // 퀴즈팩 풀이 정보 호출 
        quizPacksInfo storage r = userQuizPacksInfos[wallet][num-1];
        return(r.quizPackName, r.quizPackType, r.quizPackTag , r.wallet); 
    }

}