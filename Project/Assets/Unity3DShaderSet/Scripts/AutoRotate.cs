using UnityEngine;
using System.Collections;

public class AutoRotate : MonoBehaviour {
	public Vector3 rotation;
	Transform mTrans;
	void Awake()
	{
		mTrans = this.transform;
	}
	void Update ()
	{
		mTrans.Rotate(rotation * Time.deltaTime, Space.World);
	}
}
