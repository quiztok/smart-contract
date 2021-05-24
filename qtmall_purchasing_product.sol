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




/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
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

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}


contract QuiztokMallGoods is Ownable{

    struct goodsInfo{
        string goodsName;
        string goodsType;
        string goodsColor;
        string goodsSn;
        string goodsModelNumber;
        string goodsImgUrl;
        string goodsPurchaseDate;

    }
    
    struct goodsTxInfo{
        uint id;

    }
    mapping(uint => goodsInfo) goodsInfos;
    goodsInfo[] public goodsInfoDatas;
    
    mapping(string => goodsTxInfo) goodsTxInfos;
    goodsTxInfo[] public goodsTxInfoDatas;
    
    
    function getGoodsResultIndexNum() public view returns(uint){
     if(goodsInfoDatas.length<=0){
            return 0;
        }else{
            return goodsInfoDatas.length;
        }
    }
    
    function getGoodsInfo(uint id ) public view returns(string memory, string memory,string memory ,string memory ,string memory,string memory ,string memory){
        goodsInfo storage r = goodsInfos[id];
        return(r.goodsName,r.goodsType,r.goodsColor,r.goodsSn,r.goodsModelNumber, r.goodsImgUrl, r.goodsPurchaseDate);
    }
    
    function registerGoodsInfo(uint _id, string memory _goodsName, string memory _goodsType , string memory _goodsColor, string memory _goodsSn , 
                               string memory _goodsModelNumber , string memory _goodsImgUrl , string memory _goodsPurchaseDate ) public onlyOwner {
                                   
        uint id = _id;
        goodsInfo storage newGoodsInfo = goodsInfos[id];
        newGoodsInfo.goodsName = _goodsName;
        newGoodsInfo.goodsType = _goodsType;
        newGoodsInfo.goodsColor = _goodsColor;
        newGoodsInfo.goodsSn = _goodsSn;
        newGoodsInfo.goodsModelNumber = _goodsModelNumber;
        newGoodsInfo.goodsImgUrl = _goodsImgUrl;
        newGoodsInfo.goodsPurchaseDate = _goodsPurchaseDate;
        goodsInfoDatas.push(newGoodsInfo);
    }
    
    function getGoodsCount() public view returns(uint){
        return goodsInfoDatas.length;
    }
    

    function setGoodsTxHash(uint id , string memory _txHash ) public onlyOwner {
        goodsTxInfo storage newGoodsTxInfo = goodsTxInfos[_txHash];
        newGoodsTxInfo.id = id;
        goodsTxInfoDatas.push(newGoodsTxInfo);
    }
    
    function getGoodsByTxHash(string memory _txHash) public view returns(uint){
        goodsTxInfo storage r = goodsTxInfos[_txHash];
        return(r.id);
    }
    
}