using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Newtonsoft.Json;
using UnityEngine.Networking;
using System.Text;
using Unity.VisualScripting;

public class UnityToNode : MonoBehaviour
{
    public Button btnGetExample;
    public Button btnPostExample;
    public Button btnResDataExample;
    public string host, port, idurl, posturl, resUrl;
    public int id;
    public string data;

    private void Start()
    {
        this.btnResDataExample.onClick.AddListener(() =>
        {
            var url = string.Format("{0}:{1}/{2}", host, port, resUrl);

            StartCoroutine(this.IE_GetData(url, (raw) =>
            {
                var res = JsonConvert.DeserializeObject<Protocols.Packets.res_data>(raw);

                foreach( var user in res.result )
                {
                    Debug.LogFormat("{0}, {1}", user.id, user.data);
                }
            }));
        });

        this.btnPostExample.onClick.AddListener(() =>
        {
            var url = string.Format("{0}:{1}/{2}", host, port, posturl);
            Debug.Log(url);
            var req = new Protocols.Packets.req_data();
            req.cmd = 1000;
            req.id = id;
            req.data = data;
            var json = JsonConvert.SerializeObject(req);        // (클래스 -> JSON)

            StartCoroutine(this.IE_PostData(url, json, (raw) =>
            {
                Protocols.Packets.common res = JsonConvert.DeserializeObject<Protocols.Packets.common>(raw);
                Debug.LogFormat("{0}, {1}", res.cmd, res.message);
            }));
        });


        this.btnGetExample.onClick.AddListener(() =>
        {
            var url = string.Format("{0}:{1}/{2}", host, port, idurl);

            Debug.Log(url);
            StartCoroutine(this.IE_GetData(url, (raw) =>
            {
                var res = JsonConvert.DeserializeObject<Protocols.Packets.common>(raw);
                Debug.LogFormat("{0}, {1}", res.cmd, res.message);
            }));
        });
    }

    private IEnumerator IE_GetData(string url, System.Action<string> callback)
    {
        var webRequest = UnityWebRequest.Get(url);
        yield return webRequest.SendWebRequest();

        Debug.Log("Get : " + webRequest.downloadHandler.text);

        if (webRequest.result == UnityWebRequest.Result.ConnectionError
            || webRequest.result == UnityWebRequest.Result.ProtocolError)
        {
            Debug.Log("네트워크 환경이 좋지 않아 통신 불가능");
        }
        else
        {
            callback(webRequest.downloadHandler.text);
        }
    }

    private IEnumerator IE_PostData(string url, string json, System.Action<string> callback)
    {
        var webRequest = new UnityWebRequest(url, "POST");
        var bodyRaw = Encoding.UTF8.GetBytes(json);                 // 직렬화

        webRequest.uploadHandler = new UploadHandlerRaw(bodyRaw);
        webRequest.downloadHandler = new DownloadHandlerBuffer();
        webRequest.SetRequestHeader("Content-Type", "application/json");

        yield return webRequest.SendWebRequest();

        Debug.Log("Get : " + webRequest.downloadHandler.text);

        if (webRequest.result == UnityWebRequest.Result.ConnectionError
            || webRequest.result == UnityWebRequest.Result.ProtocolError)
        {
            Debug.Log("네트워크 환경이 좋지 않아 통신 불가능");
        }
        else
        {
            callback(webRequest.downloadHandler.text);
        }

        webRequest.Dispose();           // 통신을 끊지 않으면 경고문이 쌓임
    }
}
